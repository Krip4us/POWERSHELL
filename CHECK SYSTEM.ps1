cd $env:HOMEPATH
$random = Get-Random -Maximum 100 -Minimum 1 
Write-Host $random -ForegroundColor Red
ni -ItemType Directory -Name "$env:COMPUTERNAME;INFO;$random" -ErrorAction SilentlyContinue ; cd "$env:COMPUTERNAME;INFO;$random"

function Get_Date{
    $date = (Get-Date).ToString("yyyy.MM.dd")
    $dateSortable = (Get-Date -Format u)
    $datesort =  (Get-Date -Format T)
    $Sorter = (Get-Date -Format d)

$date ;$dateSortable ;$datesort ; $Sorter
[pscustomobject]@{
    ToString = $date
    Format = $dateSortable
    Sort = $datesort
    SortDate = $Sorter
}
}
Get_Date | out-file CHECKER.log

##############################################################################
function Check{
    Get-WmiObject -Class win32_Desktop | Out-File win32_Desktop.sys -Verbose
    "-------------------------------------------"
    systeminfo.exe | Out-File systeminfo.sys -Verbose
    "-------------------------------------------"
    Get-PSDrive | Out-File PSDrive.sys -Verbose
    "-------------------------------------------"
    Get-Service | Format-Custom | Out-File Service.sys -Verbose
    "-------------------------------------------"
    Get-Process | Out-File Process.sys -Verbose
    "-------------------------------------------"
    Get-PnpDevice | sort-object -property status -descending | Out-File PnpDevice.sys -Verbose
    "-------------------------------------------"
    Get-Disk | Out-File Disk.sys -Verbose
    "-------------------------------------------"
    Get-NetTCPConnection | Select * | Format-List | Out-File NetTCPConnection.sys -Verbose
    "-------------------------------------------"
    $wc = new-object System.Net.Webclient
    $wc.DownloadString("http://icanhazip.com/") | Out-File IPv6.sys -Verbose
    "-------------------------------------------"
    nslookup myip.opendns.com resolver1.opendns.com | Out-File NsLookup.sys -Verbose
    "-------------------------------------------"
    ipconfig.exe /displaydns | Out-File displaydns.sys -Verbose
    "-------------------------------------------"
    Get-NetAdapterBinding -Name * |Sort-Object -Property Enabled -CaseSensitive | Out-File Get-NetAdapterBinding.sys -Verbose
    "-------------------------------------------"
    Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\*\*\' | Where-Object { $_.FriendlyName } | Select-Object FriendlyName | Out-File USBSTOR.sys -Verbose
    "-------------------------------------------"
    Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | Format-List | Out-File Win32_NetworkAdapter.sys -Verbose
    "-------------------------------------------"
    nmap.exe localhost | Out-File nmap.sys -Verbose
    "-------------------------------------------"
    whoami /all | out-file whoami.sys -Verbose
    "-------------------------------------------"
    wbadmin get versions | out-file DiskVersions.sys -Verbose
    "-------------------------------------------"
    mkdir "System.Windows.NetStat" ; cd "System.Windows.NetStat"
    (NETSTAT.EXE) | Out-File "netstat--ALL--.sys" -Verbose
    (gc "netstat--ALL--.sys" | Sort-Object -Property * -Descending)-match "ESTABLISHED" | out-file "netstat--ESTABLISHED--.sys" -Verbose
    (gc "netstat--ALL--.sys" | Sort-Object -Property * -Descending)-match "TIME_WAIT" | out-file "netstat--TIME_WAIT--.sys"  -Verbose
    (gc "netstat--ALL--.sys" | Sort-Object -Property * -Descending)-match "CLOSED" | out-file "netstat--CLOSED--.sys" -Verbose
    (gc "netstat--ALL--.sys" | Sort-Object -Property * -Descending)-match "CLOSE_WAIT" | out-file "netstat--CLOSE_WAIT--.sys" -Verbose
    (gc "netstat--ALL--.sys" | Sort-Object -Property * -Descending)-match "LISTEN" | out-file "netstat--LISTEN--.sys" -Verbose

        $netstatcoUnt = (ls | Select-Object FullName).coUnt
            if ($netstatcoUnt -eq "6") {
                $netstatcoUnt = "all"
            }
            else {
                $netstatcoUnt = "less"
            }

        $netstatlength = (ls | Select-Object Length,Name | Where-Object Length -EQ "0")
            if (($netstatlength).Count -lt 7) {
                $netstatlengthcontentcoUnt = ($netstatlength.Name).Length
                $netstatlength | Out-File "FilesWithLength0"
                
            }
            else {
                $netstatlength = "all"
            }

        fUnction netstatlog{
            [pscustomobject]@{
                "exist" = $netstatcoUnt
                "filesLength0" = $netstatlengthcontentcoUnt
            }|Format-List
        }

        netstatlog | Out-File "system.Windows.Netstat.Log"

            cd ..
    "-------------------------------------------"

}

function action{
    "-------------------------------------------"
    ([System.Security.Principal.WindowsIdentity]::GetCurrent()).name | Out-File CurrentUser.sys
    "-------------------------------------------"
    (Get-WmiObject Win32_OperatingSystem | select PSComputerName,status,name,SystemDevice,Debug,Distributed,Primary | Format-List)| Out-File Win32_OperatingSystem.sys
        "-------------------------------------------"
    Get-WmiObject Win32_UserProfile | ForEach-Object{$_.LocalPath, $_.ConvertToDateTime($_.LastUseTime)}| Out-File Win32_UserProfile.sys
        "-------------------------------------------" 
    Get-WmiObject win32_process | Sort-Object Processid | Select-Object Processid,Name,CommandLine| Out-File win32_process.sys
        "-------------------------------------------"
    Get-WmiObject -Class Win32_Service | Select-Object Name,@{Name="ProcessID";Expression={$_.ProcessID;(Get-Process -Id $_.ProcessID).name}}| Out-File Win32_Service.sys
        "-------------------------------------------"
    Get-WmiObject Win32_PhysicalMemory | Select-Object ConfiguredClockSpeed| Out-File ConfiguredClockSpeed.sys
        "-------------------------------------------"
    Get-WmiObject Win32_PhysicalMemory | Select-Object MinVoltage| Out-File MinVoltage.sys
        "-------------------------------------------" 
    Get-WmiObject -class win32_service -ComputerName ASUS-DC001 | where-object name -match "WinRM" | Format-List -Property PSComputerName, Name, ExitCode, Name, ProcessID, StartMode, State, Status| Out-File WinRM.sys
        "-------------------------------------------"
    Get-WmiObject -Class Win32_VoltageProbe | Select-Object Status,Description,MaxReadable,MinReadable | Format-Table | out-file VoltageProbe.sys
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
<# FIN DEL SCRIPT DE CHECKER
.AUTHOR = krip4Us@github.com
#>
