#Para poder utilizar el fichero del perfil es necesario habilitar la ejecución de scripts
if (!(Test-Path -Path $Profile.CurrentUserAllHosts)) {
    Write-Host "file exist"
}
else {
    New-Item -Path $Profile.CurrentUserAllHosts -ItemType File -Force
}
'
Clear-Host;Set-Location $env:USERPROFILE
$date=(Get-Date).ToString("dd.MM.yyyy/HH:mm:ss");
Write-Host "
                                            #######################################
                                                        BUENOS DIAS
                                            inicio de sesion:> $date
                                                        help:commands
                                            #######################################
" -ForegroundColor Blue;
$date>>"LastAccessTime"
function tras{
    Remove-Item "LastAccessTime" -Force
    Write-Host "file lastaccesstime deleted!!!" -ForegroundColor Red
}
function renew {
    $date>>"LastAccessTime"
    Write-Host "file lastaccesstime renew!!!" -ForegroundColor Red
}
function view{
    Get-Content "LastAccessTime"
}
function findex{
    function ipfind{
        Read-Host "ip to find:help(ip examples...)>" |ForEach-Object{
       if ($_ -eq "help") {
  
           $GOOGLE = (ping "www.google.com" -n 1)
           $GOOGLE_ip = (($GOOGLE).split("[").split("]")[2])
  
           $GMAIL = (ping "www.gmail.com" -n 1)
           $GMAIL_IP = (($GMAIL).split("[").split("]")[2])
  
           $OUTLOOK =  (ping "www.outlook.com" -n 1)
           $OUTLOOK_IP = (($OUTLOOK).split("[").split("]")[2])
  
           [ordered]@{
  
               "GOOGLE.COM" = $GOOGLE_ip
               "GMAIL" = $GMAIL_IP
               "OUTLOOK" = $OUTLOOK_IP
  
           }
       }
  
       else {
  
      $baseURL = "https://whois.arin.net/rest"
      $ip = $_
      $url = "$baseUrl/ip/$ip"
      $r = Invoke-RestMethod  $url 
      $r.net.name | Out-GridView
  
       }
   }
   }
  
  function domainfind{
  
      Read-Host "domain name=>www.example.com:>"|ForEach-Object{
        $ping = ping $_ -n 1
        $pingip = (($ping).split("[").split("]")[2])
      }
      $pingip| Out-GridView
  
  }
  
  function command{
  
      Read-Host "command to use:>"|ForEach-Object{
  
      if ($_ -eq "find a ip") {
  
          domainfind
  
      }
     elseif ($_ -eq "find a domain") {
  
          ipfind
  
     }
  
     else {
  
         [ordered]@{
  
             "find a ip" = "you put a ip and resolve the DOMAIN NAME"
             "find a domain" = "you put a domain name and resolve the IP ADRESS"
  
         } 
     }
  }
  }
  
  while (1) {
  
      command
  
  }
}
function check{
    function checkerPS1{
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
    }
    Read-Host "start checker.ps1?(y/n)"|ForEach-Object{
        if ($_ -eq "y") {
            checkerPS1
        }
        elseif ($_ -eq "n") {
            Write-Host "not start" -ForegroundColor Yellow
        }
        else {
            Write-Host "connot start" -ForegroundColor Red
        }
    }
}
function ipview{
    function myip1{
        $wc = new-object System.Net.Webclient
        $ip1=$wc.DownloadString("http://icanhazip.com/")
        [PSCustomObject]@{
            "IP ICANN" = $ip1
        }
    }
    function myip2{
        $ip2 = (nslookup myip.opendns.com resolver1.opendns.com)
        $ipsplit = ($ip2.split(":"))
    
        $nameip2_1 = $ipsplit[1]
        $ip2_1 = $ipsplit[3]
    
        $nameip2_2 = $ipsplit[6]
        $ip2_2 = $ipsplit[8]
    
        [ordered]@{
            "$nameip2_1" = $ip2_1
            "$nameip2_2" = $ip2_2
        }
    }
    
    function ipcann {
       myip1 | Out-GridView
    }
    function ipreseolver{
        myip2 | Out-GridView
    }
    
    function command{
    
        Read-Host "IP VIEW:>"|ForEach-Object{
    
        if ($_ -eq "icann") {
    
            ipcann;
            write-host "you choose:$_" -ForegroundColor Green
        }
       elseif ($_ -eq "ipresolver") {
    
        ipreseolver;
        write-host "you choose:$_" -ForegroundColor Green
       }
    
       else {
    
           [ordered]@{
    
               "ipresolver" = "myip.opendns.com","resolver1.opendns.com"
               "icann" = "http://icanhazip.com/"
    
           }
       }
    }
    }
    
    while (1) {
    
        command
    
    }
}
function commands{
    [PSCustomObject]@{
        "tras"= "remove last access time file"
        "renew"= "renew last access time file"
        "view"= "get content of last access time file"
        "findex"= "find a domain name or ip"
        "check"= "check you system"
        "ipview" = "see ip public"
    }
}
    
    
'| Add-Content -Path $Profile.CurrentUserAllHosts -Encoding Default

