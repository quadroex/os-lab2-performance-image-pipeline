#requires -Version 7.0
<#
.SYNOPSIS
Read CPU RAPL energy through the documented Windows Energy Meter Interface.
.DESCRIPTION
Diagnostic launch-inclusive method. For the main program comparison use
Measure-SynchronizedEnergy.ps1, which excludes WSL startup and teardown.
Runs one command, then measures idle for the same duration. Reports raw energy
for each hardware domain and an explicitly labelled baseline-subtracted estimate.
No driver installation, admin token, power-plan change or MSR write is used.
This does not measure wall-plug energy or exact energy of an individual PID.
.EXAMPLE
./Measure-Energy.ps1 -FilePath wsl.exe -ArgumentsJson '["-d","Ubuntu-24.04","--","taskset","-c","0","/path/performance-lab/build/image_o3","--width","2048","--height","2048","--repeats","300","--seed","12345"]' -OutFile results/energy-o3.json
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$FilePath,
    [string[]]$ArgumentList = @(),
    [string]$ArgumentsJson,
    [string]$WorkingDirectory,
    [string]$Label = '',
    [ValidateRange(0,300)][double]$SettleSeconds = 5,
    [string]$OutFile
)
$ErrorActionPreference = 'Stop'
if(-not $IsWindows){ throw 'This script requires Windows. Run it on the host, outside WSL.' }
if($ArgumentsJson){ $ArgumentList = @($ArgumentsJson | ConvertFrom-Json) }

if(-not ('PerformanceLab.Emi' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
namespace PerformanceLab {
public static class Emi {
  [StructLayout(LayoutKind.Sequential)] public struct InterfaceData { public int Size; public Guid Guid; public int Flags; public IntPtr Reserved; }
  [DllImport("setupapi.dll", CharSet=CharSet.Unicode, SetLastError=true)] static extern IntPtr SetupDiGetClassDevs(ref Guid g, string e, IntPtr w, uint flags);
  [DllImport("setupapi.dll", SetLastError=true)] static extern bool SetupDiEnumDeviceInterfaces(IntPtr set, IntPtr device, ref Guid g, uint index, ref InterfaceData data);
  [DllImport("setupapi.dll", CharSet=CharSet.Unicode, SetLastError=true)] static extern bool SetupDiGetDeviceInterfaceDetail(IntPtr set, ref InterfaceData data, IntPtr detail, uint size, out uint required, IntPtr dev);
  [DllImport("setupapi.dll")] static extern bool SetupDiDestroyDeviceInfoList(IntPtr set);
  [DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)] public static extern SafeFileHandle CreateFile(string path, uint access, uint share, IntPtr security, uint creation, uint flags, IntPtr template);
  [DllImport("kernel32.dll", SetLastError=true)] static extern bool DeviceIoControl(SafeFileHandle h, uint code, IntPtr input, uint inputLen, byte[] output, uint outputLen, out uint returned, IntPtr overlapped);
  public static string[] Enumerate() {
    var paths=new List<string>(); var g=new Guid("45bd8344-7ed6-49cf-a440-c276c933b053");
    IntPtr set=SetupDiGetClassDevs(ref g,null,IntPtr.Zero,0x12);
    if(set==new IntPtr(-1)) throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
    try { for(uint i=0;;i++) { var d=new InterfaceData();d.Size=Marshal.SizeOf(typeof(InterfaceData));
      if(!SetupDiEnumDeviceInterfaces(set,IntPtr.Zero,ref g,i,ref d)) { if(Marshal.GetLastWin32Error()==259) break; throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error()); }
      uint needed; SetupDiGetDeviceInterfaceDetail(set,ref d,IntPtr.Zero,0,out needed,IntPtr.Zero);
      int error=Marshal.GetLastWin32Error();
      if(error!=122 || needed<8 || needed>1048576) throw new System.ComponentModel.Win32Exception(error,"Invalid EMI interface detail length");
      IntPtr b=Marshal.AllocHGlobal((int)needed);try { Marshal.WriteInt32(b,IntPtr.Size==8?8:6);
      if(!SetupDiGetDeviceInterfaceDetail(set,ref d,b,needed,out needed,IntPtr.Zero)) throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
      paths.Add(Marshal.PtrToStringUni(IntPtr.Add(b,4))); } finally {Marshal.FreeHGlobal(b);}
    }}finally{SetupDiDestroyDeviceInfoList(set);}return paths.ToArray();
  }
  public static byte[] Query(SafeFileHandle h,uint function,int size) {
    byte[] data=new byte[size];uint n;
    if(!DeviceIoControl(h,0x224000+(function<<2),IntPtr.Zero,0,data,(uint)data.Length,out n,IntPtr.Zero)) throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
    Array.Resize(ref data,(int)n);return data;
  }
}
}
'@
}

function Open-Sensors {
    foreach($path in [PerformanceLab.Emi]::Enumerate()) {
        $handle=[PerformanceLab.Emi]::CreateFile($path,[uint32]2147483648,3,[IntPtr]::Zero,3,0,[IntPtr]::Zero)
        if($handle.IsInvalid){ $handle.Dispose(); throw "EMI open failed: $([Runtime.InteropServices.Marshal]::GetLastWin32Error())" }
        try {
            $version=[BitConverter]::ToUInt16([PerformanceLab.Emi]::Query($handle,0,2),0)
            $size=[BitConverter]::ToUInt32([PerformanceLab.Emi]::Query($handle,1,4),0)
            if($size -lt 68 -or $size -gt 1048576){ throw "Unexpected EMI metadata size: $size" }
            $meta=[PerformanceLab.Emi]::Query($handle,2,$size)
            $channels=@()
            if($version -eq 2) {
                if($meta.Length -lt 68){throw 'Truncated EMI v2 metadata.'}
                # emi.h: two WCHAR[16] strings, revision USHORT, count USHORT.
                $count=[BitConverter]::ToUInt16($meta,66);$off=68
                if($count -eq 0){throw 'EMI device exposes no channels.'}
                for($c=0;$c -lt $count;$c++) {
                    if($off+6 -gt $meta.Length){throw 'Truncated EMI channel header.'}
                    $unit=[BitConverter]::ToUInt32($meta,$off);$len=[BitConverter]::ToUInt16($meta,$off+4)
                    # EMI_CHANNEL_V2_NEXT_CHANNEL = offset + 6 + byte length.
                    # ChannelNameSize includes the Unicode NUL; no alignment rounding.
                    if($len -lt 2 -or $len%2 -ne 0 -or $off+6+$len -gt $meta.Length){throw 'Invalid EMI channel name length.'}
                    $name=[Text.Encoding]::Unicode.GetString($meta,$off+6,$len).TrimEnd([char]0)
                    $channels += [pscustomobject]@{Name=$name;Unit=$unit};$off += 6+$len
                }
            } elseif($version -eq 1) {
                if($meta.Length -lt 74){throw 'Truncated EMI v1 metadata.'}
                $len=[BitConverter]::ToUInt16($meta,70)
                if($len -lt 2 -or $len%2 -ne 0 -or 72+$len -gt $meta.Length){throw 'Invalid EMI v1 name length.'}
                $channels += [pscustomobject]@{Name=[Text.Encoding]::Unicode.GetString($meta,72,$len).TrimEnd([char]0);Unit=[BitConverter]::ToUInt32($meta,0)}
            } else { throw "Unsupported EMI version $version" }
            [pscustomobject]@{Path=$path;Handle=$handle;Version=$version;Channels=@($channels)
                HardwareOEM=[Text.Encoding]::Unicode.GetString($meta,$(if($version -eq 1){4}else{0}),32).TrimEnd([char]0)
                HardwareModel=[Text.Encoding]::Unicode.GetString($meta,$(if($version -eq 1){36}else{32}),32).TrimEnd([char]0)}
        } catch { $handle.Dispose(); throw }
    }
}
function Get-Snapshot($Sensors) {
    $utc=[DateTimeOffset]::UtcNow.ToString('o');$rows=@()
    foreach($sensor in $Sensors) {
        $buffer=[PerformanceLab.Emi]::Query($sensor.Handle,3,16*$sensor.Channels.Count)
        if($buffer.Length -ne 16*$sensor.Channels.Count){ throw 'Incomplete EMI measurement.' }
        for($c=0;$c -lt $sensor.Channels.Count;$c++) {
            $rows += [pscustomobject]@{
                Device=$sensor.Path;Version=$sensor.Version;Channel=$sensor.Channels[$c].Name
                HardwareOEM=$sensor.HardwareOEM;HardwareModel=$sensor.HardwareModel
                UnitCode=$sensor.Channels[$c].Unit;Unit=$(if($sensor.Channels[$c].Unit -eq 0){'picowatt-hour'}else{'unsupported'})
                # Strings preserve every bit when JSON is loaded by JavaScript.
                AbsoluteEnergyPWh=[BitConverter]::ToUInt64($buffer,16*$c).ToString()
                AbsoluteTime100ns=[BitConverter]::ToUInt64($buffer,16*$c+8).ToString()
            }
        }
    }
    [pscustomobject]@{CaptureStartedUtc=$utc;CaptureFinishedUtc=[DateTimeOffset]::UtcNow.ToString('o')
        ClockSemantics='AbsoluteTime is a driver timestamp in 100 ns intervals, with unspecified epoch; only differences are used. UTC is a separate host capture clock.'
        Channels=@($rows | Sort-Object Device,Channel)}
}
function Get-Difference($Start,$End) {
    if($Start.Channels.Count -ne $End.Channels.Count){throw 'EMI channel count changed.'}
    for($i=0;$i -lt $Start.Channels.Count;$i++) {
        $a=$Start.Channels[$i];$b=$End.Channels[$i]
        if($a.Device -ne $b.Device -or $a.Channel -ne $b.Channel){ throw 'EMI channel order changed.' }
        $de=[decimal]$b.AbsoluteEnergyPWh-[decimal]$a.AbsoluteEnergyPWh
        $dt=[decimal]$b.AbsoluteTime100ns-[decimal]$a.AbsoluteTime100ns
        $status='ok';$energy=$null;$seconds=$null;$watts=$null
        if($a.UnitCode -ne 0){$status='unsupported_unit'}
        elseif($dt -le 0){$status='non_increasing_time'}
        elseif($de -lt 0){$status='counter_reset_or_wrap_not_handled_by_driver'}
        else { $energy=[double]($de*[decimal]0.0000000036);$seconds=[double]($dt*[decimal]0.0000001);$watts=$energy/$seconds
            if($de -eq 0){$status='zero_delta_unavailable_or_inactive'}
        }
        [pscustomobject]@{Device=$a.Device;Channel=$a.Channel;Status=$status;EnergyJoules=$energy;DurationSeconds=$seconds;AverageWatts=$watts}
    }
}

$sensors=@();$result=$null;$failure=$null;$ownsMutex=$false
$measurementMutex=[Threading.Mutex]::new($false,'Local\PerformanceLabEnergyMeasurement')
try {
    try {$ownsMutex=$measurementMutex.WaitOne(0)} catch [Threading.AbandonedMutexException] {$ownsMutex=$true}
    if(-not $ownsMutex){throw 'Another host energy measurement is already running. Measurements must run sequentially.'}
    $sensors=@(Open-Sensors)
    if($sensors.Count -eq 0){ throw 'No Windows EMI devices found. No energy value will be fabricated.' }
    $psi=[Diagnostics.ProcessStartInfo]::new();$psi.FileName=$FilePath
    $psi.UseShellExecute=$false;$psi.CreateNoWindow=$true
    $psi.RedirectStandardOutput=$true;$psi.RedirectStandardError=$true
    if($WorkingDirectory){$psi.WorkingDirectory=$WorkingDirectory}
    foreach($arg in $ArgumentList){$psi.ArgumentList.Add([string]$arg)}
    $process=[Diagnostics.Process]::new();$process.StartInfo=$psi
    $start=Get-Snapshot $sensors;$timer=[Diagnostics.Stopwatch]::StartNew()
    if(-not $process.Start()){throw 'Child process failed to start.'}
    # Drain both streams asynchronously to avoid a full-pipe deadlock.
    $stdoutTask=$process.StandardOutput.ReadToEndAsync();$stderrTask=$process.StandardError.ReadToEndAsync()
    $process.WaitForExit();$timer.Stop();$end=Get-Snapshot $sensors
    $exitCode=$process.ExitCode;$stdout=$stdoutTask.GetAwaiter().GetResult();$stderr=$stderrTask.GetAwaiter().GetResult()
    $process.Dispose()
    $active=@(Get-Difference $start $end)
    if($SettleSeconds -gt 0){ Start-Sleep -Seconds $SettleSeconds }
    $idleStart=Get-Snapshot $sensors
    Start-Sleep -Seconds $timer.Elapsed.TotalSeconds
    $idleEnd=Get-Snapshot $sensors
    $idle=@(Get-Difference $idleStart $idleEnd)
    $estimates=@()
    for($i=0;$i -lt $active.Count;$i++) {
        $a=$active[$i];$b=$idle[$i];$net=$null;$status='unavailable'
        if($a.Status -eq 'ok' -and $b.Status -eq 'ok') {
            $net=$a.EnergyJoules-$b.AverageWatts*$a.DurationSeconds
            $status= $(if($net -lt 0){'negative_estimate_background_or_thermal_variation'}else{'estimate'})
        }
        $estimates += [pscustomobject]@{
            Device=$a.Device;Channel=$a.Channel;Status=$status;ActiveDomainEnergyJoules=$a.EnergyJoules
            IdleAverageWatts=$b.AverageWatts;ActiveDurationSeconds=$a.DurationSeconds
            EstimatedIncrementalEnergyJoules=$net
            Formula='E_active_domain - P_idle_domain * T_active_domain'
            ExactPerProcessMeasurement=$false
            IncludeInNonOverlappingSummary=($a.Channel -match '_PKG$|_DRAM$')
        }
    }
    $warnings=@('CPU package and DRAM energy only; not whole-PC or wall-plug energy.',
        'PP0/PP1 are package subdomains: never add them to PKG.',
        'Incremental energy is a baseline-subtracted estimate, not an exact per-PID measurement.',
        'Other Windows/WSL activity, launch overhead, sensor-boundary overhead and thermal drift affect these readings.',
        'The host energy interval includes the whole child process; the program compute_seconds excludes allocation, initialization and checksum.',
        'EMI timestamps have an unspecified epoch. Only differences are used; they are never converted to UTC.',
        'EMI reports accumulated uint64 energy. A decreasing counter invalidates the interval; no speculative wrap correction is applied.',
        'Idle is measured after the active run for a matched duration, after the configured settling interval.',
        'For comparisons, use identical inputs and iteration counts; warm up first and repeat both versions.')
    if($timer.Elapsed.TotalSeconds -lt 2){$warnings += 'Run shorter than 2 seconds: launch/sensor boundary overhead may dominate.'}
    if($exitCode -ne 0){$warnings += "Child exited with code $exitCode; do not treat it as a valid benchmark."}
    $result=[ordered]@{
        SchemaVersion=1;Status=$(if($exitCode -eq 0){'ok'}else{'child_failed'});Label=$Label
        Method='Windows EMI v1/v2; read-only IOCTL_EMI_GET_MEASUREMENT; CPU RAPL domains'
        Sources=@('https://learn.microsoft.com/en-us/windows-hardware/drivers/powermeter/energy-meter-interface',
            'https://learn.microsoft.com/en-us/windows/win32/api/emi/ns-emi-emi_channel_measurement_data')
        Command=[ordered]@{FilePath=$FilePath;Arguments=@($ArgumentList);WorkingDirectory=$WorkingDirectory}
        ExitCode=$exitCode;ProcessWallSeconds=$timer.Elapsed.TotalSeconds
        StandardOutput=$stdout;StandardError=$stderr;SettleSeconds=$SettleSeconds
        RawSamples=[ordered]@{ActiveStart=$start;ActiveEnd=$end;IdleStart=$idleStart;IdleEnd=$idleEnd}
        ActiveDomainMeasurements=$active;IdleDomainMeasurements=$idle;IncrementalEstimates=$estimates
        Warnings=$warnings
    }
} catch {
    $failure=$_.Exception.Message
    $result=[ordered]@{SchemaVersion=1;Status='error';Label=$Label;Error=$failure;Utc=[DateTimeOffset]::UtcNow.ToString('o');ExactPerProcessMeasurement=$false}
} finally {
    foreach($sensor in $sensors){ $sensor.Handle.Dispose() }
    if($ownsMutex){$measurementMutex.ReleaseMutex()}
    $measurementMutex.Dispose()
}
$json=$result | ConvertTo-Json -Depth 12
if($OutFile) {
    $full=[IO.Path]::GetFullPath($OutFile);$parent=[IO.Path]::GetDirectoryName($full)
    if(-not [IO.Directory]::Exists($parent)){[IO.Directory]::CreateDirectory($parent) | Out-Null}
    [IO.File]::WriteAllText($full,$json,[Text.UTF8Encoding]::new($false))
}
$json
if($failure){throw $failure}
