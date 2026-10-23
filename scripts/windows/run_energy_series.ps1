#requires -Version 7.0
<#
.SYNOPSIS
Collect repeated host CPU-package/DRAM energy measurements for all three builds.
.DESCRIPTION
Diagnostic launch-inclusive method. For the main program comparison use
run_sync_energy_series.ps1. This older series includes WSL startup/teardown.
Runs WSL commands sequentially, pinned to one logical CPU, with identical image
dimensions, seed and repeat count. The order rotates between rounds to reduce
order bias. Each active run has a separate matched-duration idle measurement.
No energy value is attributed exactly to a PID, and no wall-plug value is claimed.
.EXAMPLE
./scripts/windows/run_energy_series.ps1 -Rounds 3 -Width 2048 -Height 2048 -Repeats 300
.EXAMPLE
./scripts/windows/run_energy_series.ps1 -Distro Ubuntu-24.04 -LinuxProjectPath /home/user/performance-lab -SkipWarmup
#>
[CmdletBinding()]
param(
    [string]$Distro='Ubuntu-24.04',
    [string]$LinuxUser='root',
    [Alias('LinuxPath')][string]$LinuxProjectPath='/mnt/q/Documents/CodexFiles/2026-10-23/x20/outputs/performance-lab',
    [ValidateRange(1,100)][int]$Rounds=3,
    [ValidateRange(1,32768)][int]$Width=2048,
    [ValidateRange(1,32768)][int]$Height=2048,
    [ValidateRange(1,1000000)][int]$Repeats=300,
    [uint32]$Seed=12345,
    [ValidateRange(0,1023)][int]$Cpu=0,
    [ValidateRange(0,300)][double]$SettleSeconds=5,
    [ValidateRange(1,1000000)][int]$WarmupRepeats=5,
    [switch]$SkipWarmup,
    [string]$OutputRoot
)
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'Run this script in PowerShell 7 on the Windows host.'}
if(-not $LinuxProjectPath.StartsWith('/')){throw 'LinuxProjectPath must be an absolute Linux path.'}
$LinuxProjectPath=$LinuxProjectPath.TrimEnd('/')
$repoRoot=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
if(-not $OutputRoot){$OutputRoot=Join-Path $repoRoot 'results'}
$folder=Join-Path ([IO.Path]::GetFullPath($OutputRoot)) ('energy-host-'+[DateTimeOffset]::UtcNow.ToString('yyyyMMddTHHmmssfffZ'))
$measureScript=Join-Path $PSScriptRoot 'Measure-Energy.ps1'
$variants=@('image_o0','image_scalar','image_o3')
$expectedBuilds=@{image_o0='O0';image_scalar='O3-scalar';image_o3='O3'}
$rows=[Collections.Generic.List[object]]::new()
$runs=[Collections.Generic.List[object]]::new()
$expectedChecksum=$null;$seriesError=$null;$ownsMutex=$false
$seriesMutex=[Threading.Mutex]::new($false,'Local\PerformanceLabEnergySeries')

function Write-JsonFile($Path,$Value) {
    [IO.File]::WriteAllText($Path,($Value|ConvertTo-Json -Depth 15),[Text.UTF8Encoding]::new($false))
}
function Get-LinuxArguments([string]$Variant,[int]$RunRepeats) {
    @('-d',$Distro,'-u',$LinuxUser,'--','taskset','-c',[string]$Cpu,
      "$LinuxProjectPath/build/$Variant",'--width',[string]$Width,'--height',[string]$Height,
      '--repeats',[string]$RunRepeats,'--seed',[string]$Seed)
}
function Invoke-LinuxWarmup([string[]]$CommandArguments) {
    $psi=[Diagnostics.ProcessStartInfo]::new();$psi.FileName='wsl.exe'
    $psi.UseShellExecute=$false;$psi.CreateNoWindow=$true
    $psi.RedirectStandardOutput=$true;$psi.RedirectStandardError=$true
    foreach($arg in $CommandArguments){$psi.ArgumentList.Add($arg)}
    $child=[Diagnostics.Process]::new();$child.StartInfo=$psi
    try {
        if(-not $child.Start()){throw 'Warmup process failed to start.'}
        $outTask=$child.StandardOutput.ReadToEndAsync();$errTask=$child.StandardError.ReadToEndAsync()
        $child.WaitForExit();$out=$outTask.GetAwaiter().GetResult();$err=$errTask.GetAwaiter().GetResult()
        if($child.ExitCode -ne 0){throw "Warmup failed (exit $($child.ExitCode)): $err"}
        $out | ConvertFrom-Json
    } finally {$child.Dispose()}
}
function Assert-Benchmark($Benchmark,[string]$Variant,[int]$RunRepeats) {
    if($Benchmark.width -ne $Width -or $Benchmark.height -ne $Height -or
       $Benchmark.repeats -ne $RunRepeats -or $Benchmark.seed -ne $Seed){
        throw "Workload metadata differs from requested workload for $Variant."
    }
    if([string]$Benchmark.build_variant -ne $expectedBuilds[$Variant]){throw "Unexpected build variant for $Variant."}
    if([string]::IsNullOrWhiteSpace([string]$Benchmark.checksum)){throw "Missing checksum for $Variant."}
    if($Benchmark.compute_seconds -le 0){throw "Invalid compute duration for $Variant."}
}
function Get-Aggregates($RunRows) {
    foreach($group in ($RunRows | Group-Object Executable,Device,Domain)) {
        $items=@($group.Group);$first=$items[0]
        $aggregate=[ordered]@{Executable=$first.Executable;BuildVariant=$first.BuildVariant
            Domain=$first.Domain;Device=$first.Device;Runs=$items.Count;Checksum=$first.Checksum}
        foreach($field in @('ComputeSeconds','ProcessWallSeconds','EnergyDurationSeconds',
            'ActiveEnergyJoules','ActiveAverageWatts','IdleEnergyJoules','IdleDurationSeconds',
            'IdleAverageWatts','IncrementalEstimateJoules')) {
            $values=@($items | ForEach-Object {$_.${field}} | Where-Object {$null -ne $_} | Sort-Object)
            if($values.Count -eq 0){continue}
            $stats=$values|Measure-Object -Average -Minimum -Maximum
            $mid=[int][Math]::Floor($values.Count/2)
            $median=if($values.Count%2){$values[$mid]}else{($values[$mid-1]+$values[$mid])/2}
            $aggregate[$field+'Mean']=$stats.Average;$aggregate[$field+'Median']=$median
            $aggregate[$field+'Min']=$stats.Minimum;$aggregate[$field+'Max']=$stats.Maximum
            $aggregate[$field+'Range']=$stats.Maximum-$stats.Minimum
            $aggregate[$field+'RangePercentOfMedian']=if($median -ne 0){100*($stats.Maximum-$stats.Minimum)/[Math]::Abs($median)}else{$null}
        }
        [pscustomobject]$aggregate
    }
}

try {
    try {$ownsMutex=$seriesMutex.WaitOne(0)} catch [Threading.AbandonedMutexException] {$ownsMutex=$true}
    if(-not $ownsMutex){throw 'Another energy series is running; measurements must not overlap.'}
    [IO.Directory]::CreateDirectory($folder)|Out-Null
    $config=[ordered]@{
        StartedUtc=[DateTimeOffset]::UtcNow.ToString('o');Distro=$Distro;LinuxUser=$LinuxUser;LinuxProjectPath=$LinuxProjectPath
        Width=$Width;Height=$Height;Repeats=$Repeats;Seed=$Seed;Cpu=$Cpu;Rounds=$Rounds
        Variants=$variants;Order='Cyclic rotation between rounds; one active and one matched-duration idle interval per run'
        SettleSeconds=$SettleSeconds;Warmup=(-not $SkipWarmup);WarmupRepeats=$WarmupRepeats
        MeasurementScript=$measureScript;WholePcMeasurement=$false;ExactPerPidMeasurement=$false
    }
    Write-JsonFile (Join-Path $folder 'configuration.json') $config
    if(-not $SkipWarmup) {
        $warmupChecksums=@();$warmupResults=@()
        foreach($variant in $variants){
            Write-Host "Warmup: $variant"
            $warmup=Invoke-LinuxWarmup (Get-LinuxArguments $variant $WarmupRepeats)
            Assert-Benchmark $warmup $variant $WarmupRepeats
            $warmupChecksums += [string]$warmup.checksum;$warmupResults += $warmup
        }
        Write-JsonFile (Join-Path $folder 'warmup.json') $warmupResults
        if(@($warmupChecksums|Select-Object -Unique).Count -ne 1){throw 'Warmup checksums differ between versions.'}
    }
    $sequence=0
    for($round=1;$round -le $Rounds;$round++){
        for($position=0;$position -lt $variants.Count;$position++){
            $variant=$variants[($position+$round-1)%$variants.Count];$sequence++
            $fileName=('run-{0:D2}-{1}.json' -f $round,$variant)
            $path=Join-Path $folder $fileName
            Write-Host "Energy $sequence/$($Rounds*$variants.Count): round $round, $variant"
            $arguments=Get-LinuxArguments $variant $Repeats
            $null=& $measureScript -FilePath 'wsl.exe' -ArgumentList $arguments -Label "$variant-round-$round" -SettleSeconds $SettleSeconds -OutFile $path
            # Validate the persisted raw record, which is the source of the summary.
            $measurement=Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
            if($measurement.Status -ne 'ok' -or $measurement.ExitCode -ne 0){throw "Invalid measurement: $fileName"}
            $benchmark=$measurement.StandardOutput | ConvertFrom-Json
            Assert-Benchmark $benchmark $variant $Repeats
            $checksum=[string]$benchmark.checksum
            if($null -eq $expectedChecksum){$expectedChecksum=$checksum}
            if($checksum -ne $expectedChecksum){throw "Checksum mismatch in $fileName; comparison invalid."}
            $runs.Add([pscustomobject]@{Round=$round;Sequence=$sequence;Executable=$variant;RawFile=$fileName;Benchmark=$benchmark})
            # Device+channel keys remain distinct if multiple packages are present.
            $selected=@($measurement.ActiveDomainMeasurements | Where-Object {$_.Channel -match '^RAPL_.*_(PKG|DRAM)$'})
            if($selected.Count -eq 0){throw 'No CPU-package/DRAM RAPL channels were exposed.'}
            foreach($active in $selected){
                $idle=@($measurement.IdleDomainMeasurements | Where-Object {$_.Device -eq $active.Device -and $_.Channel -eq $active.Channel})
                $estimate=@($measurement.IncrementalEstimates | Where-Object {$_.Device -eq $active.Device -and $_.Channel -eq $active.Channel})
                if($active.Status -ne 'ok' -or $idle.Count -ne 1 -or $idle[0].Status -ne 'ok' -or $estimate.Count -ne 1){throw "Unavailable/ambiguous measurement for $($active.Channel) in $fileName"}
                $rows.Add([pscustomobject]@{
                    Round=$round;Sequence=$sequence;Executable=$variant;BuildVariant=$benchmark.build_variant
                    Domain=$active.Channel;Device=$active.Device;Checksum=$checksum
                    Width=$Width;Height=$Height;Repeats=$Repeats;Seed=$Seed;PinnedLogicalCpu=$Cpu
                    ComputeSeconds=$benchmark.compute_seconds;ProcessWallSeconds=$measurement.ProcessWallSeconds
                    EnergyDurationSeconds=$active.DurationSeconds;ActiveEnergyJoules=$active.EnergyJoules
                    ActiveAverageWatts=$active.AverageWatts;IdleEnergyJoules=$idle[0].EnergyJoules
                    IdleDurationSeconds=$idle[0].DurationSeconds;IdleAverageWatts=$idle[0].AverageWatts
                    IncrementalEstimateJoules=$estimate[0].EstimatedIncrementalEnergyJoules
                    EstimateStatus=$estimate[0].Status;RawFile=$fileName
                })
            }
        }
    }
} catch { $seriesError=$_.Exception.Message }
finally {
    if(Test-Path -LiteralPath $folder){
        if($rows.Count -gt 0){$rows|Export-Csv -LiteralPath (Join-Path $folder 'measurements.csv') -NoTypeInformation -Encoding utf8}
        $aggregates=@(Get-Aggregates $rows)
        if($aggregates.Count -gt 0){$aggregates|Export-Csv -LiteralPath (Join-Path $folder 'summary.csv') -NoTypeInformation -Encoding utf8}
        $summary=[ordered]@{
            Status=$(if($seriesError){'error'}else{'ok'});Error=$seriesError;FinishedUtc=[DateTimeOffset]::UtcNow.ToString('o')
            ExpectedChecksum=$expectedChecksum;ChecksumValidation='Every measured run must have the same checksum and requested workload metadata'
            CompletedRuns=$runs.Count;RequestedRuns=$Rounds*$variants.Count;Aggregates=$aggregates;Measurements=@($rows.ToArray())
            Interpretation=@('ActiveEnergyJoules is total energy of the named hardware domain during the child process, including background activity.',
                'IncrementalEstimateJoules = active-domain energy minus matched-idle watts times the active-domain duration; it is an estimate, not exact per-PID energy.',
                'PKG and DRAM are kept separate. PP0/PP1 are excluded to avoid adding package subdomains twice.',
                'No whole-computer or wall-plug energy is measured.',
                'Durations use two scopes: program compute_seconds and host interval including WSL launch, allocation, initialization, checksum, teardown and sensor-boundary overhead.',
                'Other host work, VM overhead, thermal drift and launch overhead can affect both active and idle measurements.',
                'Min/max/range describe observed variation across rounds, not a statistical confidence interval.')
        }
        Write-JsonFile (Join-Path $folder 'summary.json') $summary
    }
    if($ownsMutex){$seriesMutex.ReleaseMutex()};$seriesMutex.Dispose()
}
if($seriesError){throw "Energy series failed: $seriesError. Partial results: $folder"}
Write-Host "Energy series complete. Checksum: $expectedChecksum"
$folder
