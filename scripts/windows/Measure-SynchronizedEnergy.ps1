#requires -Version 7.0
<#
.SYNOPSIS
Measure host RAPL energy around a Linux child after WSL has already started.
.DESCRIPTION
READY/GO/DONE/ACK excludes WSL startup and teardown from the energy interval.
The interval includes target launch, allocation, initialization, computation,
checksum and child teardown, plus small wrapper/pipe/sensor-boundary overhead.
Energy is hardware-domain energy, not whole-PC or exact per-PID energy.
#>
[CmdletBinding()]
param(
    [string]$Distro='Ubuntu-24.04',
    [string]$LinuxUser='root',
    [string]$LinuxProjectPath='/mnt/c/projects/performance-lab',
    [Parameter(Mandatory)][string[]]$TargetArguments,
    [string]$Label='',
    [ValidateRange(0,300)][double]$SettleSeconds=5,
    [ValidateRange(1,300)][double]$HandshakeTimeoutSeconds=30,
    [ValidateRange(1,3600)][double]$ChildTimeoutSeconds=90,
    [string]$OutFile
)
$ErrorActionPreference='Stop'
if(-not $IsWindows){throw 'Run in PowerShell 7 on the Windows host.'}
. (Join-Path $PSScriptRoot 'Emi-Sensors.ps1')

function Read-ProtocolText($Process,[string]$Expected,[double]$TimeoutSeconds) {
    $line=$Process.StandardOutput.ReadLineAsync().WaitAsync([TimeSpan]::FromSeconds($TimeoutSeconds)).GetAwaiter().GetResult()
    if($null -eq $line){throw "Wrapper stdout closed while expecting $Expected."}
    $line
}
function Read-ProtocolLine($Process,[string]$Expected,[double]$TimeoutSeconds) {
    $line=Read-ProtocolText $Process $Expected $TimeoutSeconds
    try {$message=$line|ConvertFrom-Json} catch {throw "Invalid wrapper protocol line while expecting ${Expected}: $line"}
    if($message.type -ne $Expected){throw "Expected $Expected, received $line"}
    $message
}
function Send-Control($Process,[string]$Message) {
    $Process.StandardInput.WriteLine($Message);$Process.StandardInput.Flush()
}

$sensors=@();$result=$null;$failure=$null;$ownsMutex=$false;$process=$null
$measurementMutex=[Threading.Mutex]::new($false,'Local\PerformanceLabEnergyMeasurement')
try {
    try {$ownsMutex=$measurementMutex.WaitOne(0)} catch [Threading.AbandonedMutexException] {$ownsMutex=$true}
    if(-not $ownsMutex){throw 'Another host energy measurement is running. Measurements must be sequential.'}
    $arguments=@('-d',$Distro,'-u',$LinuxUser,'--','python3','-u',
        "$($LinuxProjectPath.TrimEnd('/'))/scripts/linux/energy_child.py",
        '--timeout',[string]$ChildTimeoutSeconds,'--control-timeout',[string]$HandshakeTimeoutSeconds,'--')+@($TargetArguments)
    $psi=[Diagnostics.ProcessStartInfo]::new();$psi.FileName='wsl.exe'
    $psi.UseShellExecute=$false;$psi.CreateNoWindow=$true
    $psi.RedirectStandardInput=$true;$psi.RedirectStandardOutput=$true;$psi.RedirectStandardError=$true
    $psi.StandardOutputEncoding=[Text.Encoding]::UTF8;$psi.StandardErrorEncoding=[Text.Encoding]::UTF8
    foreach($arg in $arguments){$psi.ArgumentList.Add([string]$arg)}
    $process=[Diagnostics.Process]::new();$process.StartInfo=$psi
    $sessionTimer=[Diagnostics.Stopwatch]::StartNew()
    if(-not $process.Start()){throw 'WSL wrapper failed to start.'}
    $hostStderrTask=$process.StandardError.ReadToEndAsync()
    $ready=Read-ProtocolLine $process 'READY' $HandshakeTimeoutSeconds
    $startupSeconds=$sessionTimer.Elapsed.TotalSeconds
    # Sensor enumeration and a priming read happen while the wrapper waits.
    $sensors=@(Open-Sensors)
    if($sensors.Count -eq 0){throw 'No EMI devices found. No energy values will be fabricated.'}
    $null=Get-Snapshot $sensors
    $start=Get-Snapshot $sensors
    $syncTimer=[Diagnostics.Stopwatch]::StartNew()
    Send-Control $process 'GO'
    $doneText=Read-ProtocolText $process 'DONE' ($ChildTimeoutSeconds+10)
    $end=Get-Snapshot $sensors
    $syncTimer.Stop()
    # Parse after capturing the endpoint, while the wrapper still waits for ACK.
    $done=$doneText|ConvertFrom-Json
    if($done.type -ne 'DONE'){throw "Expected DONE, received $doneText"}
    Send-Control $process 'ACK'
    $childResult=Read-ProtocolLine $process 'RESULT' $HandshakeTimeoutSeconds
    if(-not $process.WaitForExit([int]($HandshakeTimeoutSeconds*1000))){throw 'Wrapper did not exit after RESULT.'}
    $sessionTimer.Stop()
    $wrapperExitCode=$process.ExitCode;$hostStderr=$hostStderrTask.GetAwaiter().GetResult()
    $active=@(Get-Difference $start $end)
    if($SettleSeconds -gt 0){Start-Sleep -Seconds $SettleSeconds}
    $idleStart=Get-Snapshot $sensors
    Start-Sleep -Seconds $syncTimer.Elapsed.TotalSeconds
    $idleEnd=Get-Snapshot $sensors
    $idle=@(Get-Difference $idleStart $idleEnd)
    $estimates=@()
    for($i=0;$i -lt $active.Count;$i++) {
        $a=$active[$i];$b=$idle[$i];$net=$null;$status='unavailable'
        if($a.Status -eq 'ok' -and $b.Status -eq 'ok'){
            $net=$a.EnergyJoules-$b.AverageWatts*$a.DurationSeconds
            $status=if($net -lt 0){'negative_estimate_background_or_thermal_variation'}else{'estimate'}
        }
        $estimates += [pscustomobject]@{
            Device=$a.Device;Channel=$a.Channel;Status=$status;ActiveDomainEnergyJoules=$a.EnergyJoules
            IdleAverageWatts=$b.AverageWatts;ActiveDurationSeconds=$a.DurationSeconds
            EstimatedIncrementalEnergyJoules=$net;Formula='E_active_domain - P_idle_domain * T_active_domain'
            ExactPerProcessMeasurement=$false;IncludeInNonOverlappingSummary=($a.Channel -match '_PKG$|_DRAM$')
        }
    }
    $valid=($childResult.exit_code -eq 0 -and -not $childResult.timed_out -and -not $childResult.error -and $wrapperExitCode -eq 0)
    $warnings=@('CPU package and DRAM only; no wall-plug or whole-PC energy measurement.',
        'The synchronized interval excludes WSL startup/teardown but includes the whole Linux child and small wrapper/pipe/sensor-boundary overhead.',
        'The program compute_seconds excludes allocation, initialization and checksum; energy covers those operations.',
        'Idle baseline follows the active interval after the configured settling time and matches its duration.',
        'Other Windows/WSL activity, thermal drift and virtualization affect readings.',
        'Baseline subtraction is an incremental estimate, not an exact per-PID measurement.',
        'PP0/PP1 are subdomains and must never be added to PKG.',
        'EMI time has an unspecified epoch; only differences in 100 ns units are used. Decreasing energy counters invalidate an interval.')
    if($syncTimer.Elapsed.TotalSeconds -lt 2){$warnings += 'Interval shorter than 2 seconds: boundary overhead may dominate.'}
    $result=[ordered]@{
        SchemaVersion=2;Status=$(if($valid){'ok'}else{'child_failed'});Label=$Label
        Method='Windows EMI RAPL; synchronized Linux child via READY/GO/DONE/ACK/RESULT'
        Command=[ordered]@{FilePath='wsl.exe';Arguments=$arguments;TargetArguments=@($TargetArguments)}
        Sources=@('https://learn.microsoft.com/en-us/windows-hardware/drivers/powermeter/energy-meter-interface',
            'https://learn.microsoft.com/en-us/windows/win32/api/emi/ns-emi-emi_channel_measurement_data')
        ExitCode=$childResult.exit_code;WrapperExitCode=$wrapperExitCode;TimedOut=$childResult.timed_out
        StandardOutput=$childResult.stdout;StandardError=$childResult.stderr;HostStandardError=$hostStderr
        ProcessWallSeconds=$sessionTimer.Elapsed.TotalSeconds
        ProcessWallScope='Full WSL host process, including startup and teardown; not the energy window'
        FullHostProcessWallSeconds=$sessionTimer.Elapsed.TotalSeconds;WslStartupToReadySeconds=$startupSeconds
        SynchronizedWallSeconds=$syncTimer.Elapsed.TotalSeconds;EnergyWindowScope='GO through DONE, before ACK permits wrapper teardown'
        LinuxChildWallSeconds=$childResult.child_wall_seconds;LinuxChildRealtimeSeconds=$childResult.child_realtime_seconds
        ClockCrosscheck=[ordered]@{HostStopwatchFrequency=[Diagnostics.Stopwatch]::Frequency
            GuestMonotonicSeconds=$childResult.child_wall_seconds;GuestRealtimeSeconds=$childResult.child_realtime_seconds
            HostQpcWindowSeconds=$syncTimer.Elapsed.TotalSeconds
            ClockWarning='Guest monotonic/realtime and host QPC/EMI are different clocks and scopes. Differences are diagnostic, not a proven overhead decomposition.'}
        WrapperReady=$ready;Completion=$done;SettleSeconds=$SettleSeconds
        RawSamples=[ordered]@{ActiveStart=$start;ActiveEnd=$end;IdleStart=$idleStart;IdleEnd=$idleEnd}
        ActiveDomainMeasurements=$active;IdleDomainMeasurements=$idle;IncrementalEstimates=$estimates;Warnings=$warnings
    }
} catch {
    $failure=$_.Exception.Message
    $result=[ordered]@{SchemaVersion=2;Status='error';Label=$Label;Error=$failure;Utc=[DateTimeOffset]::UtcNow.ToString('o');ExactPerProcessMeasurement=$false}
} finally {
    if($null -ne $process){
        try {if(-not $process.HasExited){$process.Kill($true)}}catch{}
        $process.Dispose()
    }
    foreach($sensor in $sensors){$sensor.Handle.Dispose()}
    if($ownsMutex){$measurementMutex.ReleaseMutex()};$measurementMutex.Dispose()
}
$json=$result|ConvertTo-Json -Depth 15
if($OutFile){
    $full=[IO.Path]::GetFullPath($OutFile);$parent=[IO.Path]::GetDirectoryName($full)
    [IO.Directory]::CreateDirectory($parent)|Out-Null
    [IO.File]::WriteAllText($full,$json,[Text.UTF8Encoding]::new($false))
}
$json
if($failure){throw $failure}
