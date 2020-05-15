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
    date >> "LastAccessTime" 
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
    function starter{        
        $date = date
        $view = view
        $viewlenth = (view).count
        gc $env:USERPROFILE\LastAccessTime
        renew
        Write-Host "
        #######################################################
                    inicio de sesion        ==>  $date      
                    HELP COMMANDS           ==>  commands
                    LastAccessTime length   ==> $viewlenth
        #######################################################
        " -ForegroundColor GREEN ;
    }
    if( ((gc .\LastAccessTime -ErrorAction SilentlyContinue).length -gt 1) -eq "True" ){
        starter
    }
    elseif ( (Test-Path $env:USERPROFILE\LastAccessTime) -eq "False" ) {
        Add-Content $date -path "LastAccessTime" ; starter 
    }
    else {
        renew ; starter
    }
    }
function tasker {
    function test{
        if (!(Test-Path $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\injection.ps1 ) -eq "True") {
            cd $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\ ;
            New-Item -ItemType File -Value "tras ; renew ; renew ; getstart" -Name "injection.ps1" -ErrorAction SilentlyContinue
            $test = "none"
        }
        else {
            Write-Host ".\injection.ps1 exist" 
            $test = "ok"
        }
        }
        
    start-process powershell{ Invoke-Expression $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\injection.ps1 }
        }
if (((view).count -gt 19)-eq "True") {
    tasker
}
else {
    $test::"ok" 
    Write-Host "LastAccessTime file length less than 20"
}
getstart

function findex{
    function ipfind{
        Read-Host "ip to find: help(ip examples...)>" |ForEach-Object{
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
        while (1) {
            domainfind            
            }
        }
     elseif ($_ -eq "find a domain") {
        while (1) {
            ipfind
        }
     }
     elseif($_ -eq "exit"){
        break;
     }
     else {
        [ordered]@{
            "find a ip" = "you put a DOMAIN NAME and resolve the IP"
            "find a domain" = "you put a IP ADRESS and resolve the IP"
            "exit" = "exit interactive console"
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
            "-------------------------------------------"
            systeminfo.exe | Out-File systeminfo.sys -Verbose
            "-------------------------------------------"
            Get-PSDrive | Out-File PSDrive.sys -Verbose
            "-------------------------------------------"
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
            nmap.exe localhost | Out-File nmap.sys
            "-------------------------------------------"
            whoami /all | out-file whoami.sys
            "-------------------------------------------"
            wbadmin get versions | out-file DiskVersions.sys
        }
               
        function action{
            "-------------------------------------------"
            ([System.Security.Principal.WindowsIdentity]::GetCurrent()).name | Out-File CurrentUser.sys
            "-------------------------------------------"        
            "-------------------------------------------"  
            }

$CodigoC = @"

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
 
public static class User32
{
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
        public static extern bool MessageBox(
            IntPtr hWnd,     /// Parent window handle 
            String text,     /// Text message to display
            String caption,  /// Window caption
            int options);    /// MessageBox type
}

"@

    function ask{
        Add-Type -TypeDefinition $CodigoC -ErrorAction SilentlyContinue
        [System.Windows.MessageBox]::Show('continuen command: check?','Game input','YesNoCancel','Warning') |%{
            if($_ -eq "Yes"){ls}
            elseif($_ -eq "No"){ps}
            else{$_ ; break}
        }
    }
        #################
        Check ;
        #################
        if(($psversiontable.PSVersion.major)-gt 5){
            write-host "POWERSHELL VERSION GRATHER THAN 5.0.0" -ForegroundColor Magenta
          }
          elseif(($psversiontable.PSVersion.major)-lt 7){
            ask ;
            Get-Service | Format-Custom | Out-File Service.sys -Verbose
            "-------------------------------------------"
            $iniciossesion = Get-EventLog -LogName Security -ComputerName $env:COMPUTERNAME -InstanceId 4624 |
            ForEach-Object {
              # Convertir el contenido del log en un objeto
              [PSCustomObject]@{
                  Time = $_.TimeGenerated
                  Usuario = "{0}\{1}" -f $_.ReplacementStrings[5], $_.ReplacementStrings[6]
                  Type = $_.ReplacementStrings[10]
                  Path = $_.ReplacementStrings[17]
              }
            }   
            $iniciossesion | Sort-Object Usuario -Descending | Group-Object -Property Usuario | Format-Custom | Out-File " account was successfully logged on.sys"
            "-------------------------------------------"
          }
          else{
            write-host "info: " -ForegroundColor Yellow -nonewline;write-host "CAN'T CHECK POWERSHELL VERSION" -ForegroundColor Magenta ; continue
          }
        #################
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
function removecheckers {
$rootPath = $env:USERPROFILE
    (ls $rootPath | Where-Object name -Match "$env:COMPUTERNAME;INFO;" | Select-Object FullName) | ForEach-Object{
        Remove-Item $_.FullName -Recurse -Force -Verbose -Confirm:$true
    }
}
function commands{
    Write-Host "__________________________________________________________________"
    Write-Host "AUTHOR      : krip4us@github.com" -ForegroundColor Green 
    Write-Host "NAME        : interactive console for starting powershel" -ForegroundColor Red
    Write-Host "NAME PS1    : profile.ps1" -ForegroundColor Red
    Write-Host "EXTENSION   : .ps1 (powershell scripts file extension predefined )" -ForegroundColor Blue
    Write-Host "PATH        : $env:USERPROFILE\Documents\WindowsPowershell" -ForegroundColor Magenta
    Write-Host "__________________________________________________________________
COMMANDS:
---------"
    [PSCustomObject]@{
        "getstart" = "display the first message that you see"
        "tras" = "remove last access time file"
        "renew" = "renew last access time file"
        "view" = "get content of last access time file"
        "findex"= "find a domain name or ip"
        "check" = "check you system"
        "viewcheck" = "view the last checker file compressed. (REQUIRED: command->'check'run before)"
        "removecheckers" = "remove all last checker files"
        "ipview" = "see ip public"
        "updateconsole" = "update interactive console"
    }
}
'| Add-Content -Path $Profile.CurrentUserAllHosts -Encoding Default
<# FIN DEL SCRIPT DE INTERACTIVE CONSOLE
.AUTHOR = krip4Us@github.com
#>
