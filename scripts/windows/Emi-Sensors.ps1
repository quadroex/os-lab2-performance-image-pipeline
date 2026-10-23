# Read-only Windows EMI implementation shared by synchronized measurement scripts.
# Derived from Measure-Energy.ps1; raw counters are never converted to a UTC epoch.
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
