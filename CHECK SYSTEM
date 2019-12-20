```PowerShell
cd $env:SystemDrive\
$random = Get-Random -Maximum 100 -Minimum 1 
$random
ni -ItemType Directory -Name "$env:COMPUTERNAME;INFO;$random" -ErrorAction SilentlyContinue ; cd "$env:COMPUTERNAME;INFO;$random"

function Get_Date{
    $date = (Get-Date).ToString("yyyy.MM.dd")
    $dateSortable = (Get-Date -Format u)
    $datesort =  (Get-Date -Format T)
    $Sorter = (Get-Date -Format d)

$date ;$dateSortable ;$datesort ; $Sorter
@{
    ToString = $date
    Format = $dateSortable
    Sort = $datesort
    SortDate = $Sorter
}

}
Get_Date | out-file CHECKER.log



##############################################################################
function Check{
    Get-WmiObject -Class win32_Desktop | Out-File win32_Desktop.sys
    systeminfo.exe | Out-File systeminfo.sys
    Get-PSDrive | Out-File PSDrive.sys
    Get-Service | Format-Custom | Out-File Service.sys
    Get-Process | Out-File Process.sys
    Get-PnpDevice | sort-object -property status -descending | Out-File PnpDevice.sys
    Get-Disk | Out-File Disk.sys
    Get-NetTCPConnection | Select * | Format-List | Out-File NetTCPConnection.sys
    $wc = new-object System.Net.Webclient
    $wc.DownloadString("http://icanhazip.com/") | Out-File IPv6.sys
    nslookup myip.opendns.com resolver1.opendns.com | Out-File NsLookup.sys
    ipconfig.exe /displaydns
    Get-NetAdapterBinding -Name 'USB-ETH1','Ethernet 2' |Sort-Object -Property Enabled -CaseSensitive | Out-File 'Get-NetAdapterBinding.sys'
    Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\*\*\' | Where-Object { $_.FriendlyName } | Select-Object FriendlyName | Out-File 'USBSTOR.sys'
    Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | Format-List | Out-File Win32_NetworkAdapter.sys
}

function action{
    "-------------------------------------------"
    ([System.Security.Principal.WindowsIdentity]::GetCurrent()).name | Out-File CurrentUser.sys
    "-------------------------------------------"
    (Get-WmiObject Win32_OperatingSystem | select PSComputerName,status,name,SystemDevice,Debug,Distributed,Primary | Format-List)| Out-File Win32_OperatingSystem.sys
        "-------------------------------------------"
    Get-WmiObject Win32_UserProfile | %{$_.LocalPath, $_.ConvertToDateTime($_.LastUseTime)}| Out-File Win32_UserProfile.sys
        "-------------------------------------------" 
    Get-WmiObject win32_process | Sort-Object Processid | Select-Object Processid,Name,CommandLine| Out-File win32_process.sys
        "-------------------------------------------"
    Get-WmiObject -Class Win32_Service | Select-Object Name,@{Name="ProcessID";Expression={$_.ProcessID;(Get-Process -Id $_.ProcessID).name}}| Out-File Win32_Service.sys
        "-------------------------------------------"
    Get-WmiObject Win32_PhysicalMemory | Select-Object ConfiguredClockSpeed| Out-File ConfiguredClockSpeed.sys
        "-------------------------------------------"
    Get-WmiObject Win32_PhysicalMemory | Select-Object MinVoltage| Out-File MinVoltage.sys
        "-------------------------------------------" 
    Get-WmiObject -Query "select * from win32_service where name='WinRM'" -ComputerName $env:COMPUTERNAME | Format-List -Property PSComputerName, Name, ExitCode, Name, ProcessID, StartMode, State, Status| Out-File WinRM.sys
        "-------------------------------------------"

    }
    
#################
Check ;
action  
#################
Set-Location ..;
Compress-Archive -Path  "$env:COMPUTERNAME;INFO;$random" -DestinationPath  "$env:COMPUTERNAME;INFO;$random.zip";
if ((Test-Path "$env:COMPUTERNAME;INFO;$random.zip")-eq 'True') {
    rmdir "$env:COMPUTERNAME;INFO;$random" -Recurse -Force;
'________________________________________________________________________________________________'
Write-Host "CHECKER FINISH COMPLETE!!" -ForegroundColor Green
'________________________________________________________________________________________________'
exit
}
else {
    Write-Host 'checker complete but not compressed' -ForegroundColor Red
    Start-Sleep -Seconds 6;exit
}
```
