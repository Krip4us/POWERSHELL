#TENEIS QUE TENER HABILITADO LA EJECUCION DE SCRIPTS ==> start-process powershell{Set-ExecutionPolicy Unrestricted}-verb runas
if (!(Test-Path -Path $Profile.CurrentUserAllHosts)) {
    Write-Host "file exist"
}
else {
    New-Item -Path $Profile.CurrentUserAllHosts -ItemType File -Force
}
'

Clear-Host;Set-Location $env:USERPROFILE
function date{
    (Get-Date).ToString("dd.MM.yyyy/HH:mm:ss"); 
}
function renew {
    date >>"LastAccessTime"
    Write-Host "file lastaccesstime renew!!!" -ForegroundColor Red
}
function view{
    Get-Content "LastAccessTime" -ErrorAction SilentlyContinue
}
function tras{
    Remove-Item "LastAccessTime" -Force
    Write-Host "file lastaccesstime deleted!!!" -ForegroundColor Red
}
function getstart{
    $date = date
    $view = view
    $viewlenth = (view).length
    ($view)[0..$viewlenth]
    date >>"LastAccessTime"
    
    Write-Host "
    #######################################################
                inicio de sesion        ==>  $date      
                HELP COMMANDS           ==>  commands
                LastAccessTime length   ==> $viewlenth
    #######################################################
    " -ForegroundColor GREEN ;
    function injection {
        if (!(Test-Path $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\injection.ps1 ) -eq "True") {
            cd $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\ ;
            New-Item -ItemType File -Value "tras ; renew ; renew ; getstart" -Name "injection.ps1" -ErrorAction SilentlyContinue
        }
        else {
            Write-Host ".\injection.ps1 exist"
        }
    }
    injection
    if ($viewlenth -gt 20) {
        tras ; renew ; renew 
    }
    
    else {
        Write-Host "FileAccessTime less than 20"
    }
    
}
getstart

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
        <#
        if ($_ -eq "exit") {
            [System.Windows.Forms.SendKeys]::SendWait("exit")
        }
      
        #>
    }
      $pingip| Out-GridView
  }
  
  function command{
  
      Read-Host "command to use:>"|ForEach-Object{
  
      if ($_ -eq "find a ip") {
        while (1) {
            domainfind
        }
      }
     elseif ($_ -eq "find a domain") {
        while (1) {
            ipfind
        }
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
        function LastLog{
            $Sorter+"-"+$datesort| Out-File "LastCheck.log"
        }
        LastLog
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
            Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\*\*\" | Where-Object { $_.FriendlyName } | Select-Object FriendlyName | Out-File USBSTOR.sys -Verbose
            "-------------------------------------------"
            Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | Format-List | Out-File Win32_NetworkAdapter.sys -Verbose
            "-------------------------------------------"
            nmap.exe localhost | Out-File nmap.sys
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
            Get-WmiObject -class win32_service -ComputerName ASUS-DC001 | where-object name -match "WinRM" | Format-List -Property PSComputerName, Name, ExitCode, Name, ProcessID, StartMode, State, Status| Out-File WinRM.sys
                "-------------------------------------------"
        
            }
            
        #################
        Check ;
        action  
        #################
        Set-Location ..;
        Compress-Archive -Path  "$env:COMPUTERNAME;INFO;$random" -DestinationPath  "$env:COMPUTERNAME;INFO;$random.zip";
        if ((Test-Path "$env:COMPUTERNAME;INFO;$random.zip")-eq "True") {
            rmdir "$env:COMPUTERNAME;INFO;$random" -Recurse -Force;
        Write-Host "CHECKER FINISH COMPLETE!!" -ForegroundColor Green
        }
        else {
            Write-Host "checker complete but not compressed" -ForegroundColor Red
            Start-Sleep -Seconds 6
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
            Write-Warning "connot start" 
    }
}
}
function viewcheck {
    $file = ((ls ("G:\FileHistory","$env:USERPROFILE") |Where-Object Extension -EQ ".zip" | Sort-Object -Property LastWriteTime -Descending | Select-Object FullName ).FullName)[0]
    $newname = $file.split(".")[0]
    Expand-Archive -Path $file -DestinationPath $newname
    if ((Test-Path -Path $newname)-eq "True") {
        rm $file
        Set-Location $newname
         cd ($newname.Split("\")[2])
        ls
        Write-Host (gc .\CHECKER.log)[0] -ForegroundColor Green
    }
    else {
        Write-Warning "Cannot view check on:: $file"
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
function updateconsole{
    iex (new-object net.webclient).downloadstring("https://raw.githubusercontent.com/Krip4us/POWERSHELL/master/Interactive%20Console.ps1") -Verbose
}
        function commands{
            [PSCustomObject]@{
                "tras" = "remove last access time file"
                "renew" = "renew last access time file"
                "view" = "get content of last access time file"
                "findex"= "find a domain name or ip"
                "check" = "check you system"
                "ipview" = "see ip public"
                "viewcheck" = "view the last checker file compress"
                "updateconsole" = "update interactive console"
            }
        }
'| Add-Content -Path $Profile.CurrentUserAllHosts -Encoding Default
<# FIN DEL SCRIPT DE INTERACTIVE CONSOLE
.AUTHOR = krip4Us@github.com
#>
