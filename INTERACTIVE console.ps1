
Clear-Host;Set-Location $env:USERPROFILE
function dateon{
    (Get-Date).ToString("dd.MM.yyyy/HH:mm:ss"); 
}
function renew {
    dateon >> "LastAccessTime" 
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
        $date = Get-date
        $viewlenth = (view).count
        Get-Content $env:USERPROFILE\LastAccessTime
        renew
        Write-Host "
        #######################################################
                    inicio de sesion        ==>  $date      
                    HELP COMMANDS           ==>  commands
                    LastAccessTime length   ==> $viewlenth
        #######################################################
        " -ForegroundColor GREEN ;
    }
    if( ((Get-Content .\LastAccessTime -ErrorAction SilentlyContinue).length -gt 1) -eq "True" ){
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
            Set-Location $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\ ;
            New-Item -ItemType File -Value "tras ; renew ; renew ; getstart" -Name "injection.ps1" -ErrorAction SilentlyContinue
        }
        else {
            Write-Host ".\injection.ps1 exist" 

        }
    }
        
    start-process powershell{ Invoke-Expression $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\injection.ps1 }
}
if (((view).count -gt 19)-eq "True") {
    tasker
}
else {
    Write-Host "LastAccessTime file length less than 20"
}
getstart

function findex{
    function ipfind{
        switch (read-host "IP:") {
            help { 
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
            Default {
                $baseURL = "https://whois.arin.net/rest"
                $ip = $_
                $url = "$baseUrl/ip/$ip"
                $r = Invoke-RestMethod  $url 
                $r.net.name | Out-GridView
            }
        }
    }
  
    function domainfind{
        switch (Read-Host "domain name (example.com)") {
            Default {
                $ping = ping $_ -n 1
                $pingresult = (($ping).split("[").split("]")[2])
                $pingresult | Out-GridView
            }
        }
    }
  
    function commandread{
        switch (read-host "ipfind / domainfind") {
            ipfind { ipfind }
            domainfind { domainfind }
            Default {
                [ordered]@{
                    "ipfind" = "Buscar IP a traves de un nombre de un DOMINIO"
                    "domainfind" = "Buscar DOMINIO a traves de una IP"     
                } 
            }
        }
    }

    while (1) {  
        commandread
    }
} # end findex
function check{
    function checkerPS1{
        $random = Get-Random -Maximum 100 -Minimum 1 
        $random
        New-Item -ItemType Directory -Name "$env:COMPUTERNAME;INFO;$random" -ErrorAction SilentlyContinue ; Set-Location "$env:COMPUTERNAME;INFO;$random"
        
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
            Get-Service * | Format-Custom | Out-File Service.sys -Verbose
            "-------------------------------------------"
            Get-Process | Out-File Process.sys -Verbose
            "-------------------------------------------"
            Get-PnpDevice | sort-object -property status -descending | Out-File PnpDevice.sys -Verbose
            "-------------------------------------------"
            Get-Disk | Out-File Disk.sys -Verbose
            "-------------------------------------------"
            Get-NetTCPConnection | Select-Object * | Format-List | Out-File NetTCPConnection.sys -Verbose
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
            #nmap.exe localhost | Out-File nmap.sys
            "-------------------------------------------"
            whoami /all | out-file whoami.sys
            "-------------------------------------------"
            wbadmin get versions | out-file DiskVersions.sys
        }
               
        function action{
            "-------------------------------------------"
            ([System.Security.Principal.WindowsIdentity]::GetCurrent()).name | Out-File CurrentUser.sys
            "-------------------------------------------"        
            }
            
        #################
        Check ;
        action  
        #################
        Set-Location ..;
        Compress-Archive -Path  "$env:COMPUTERNAME;INFO;$random" -DestinationPath  "$env:COMPUTERNAME;INFO;$random.zip";
        switch ((Test-Path "$env:COMPUTERNAME;INFO;$random.zip")) {
            True { 
                Remove-Item "$env:COMPUTERNAME;INFO;$random" -Recurse -Force;
                Write-Host "CHECKER FINISH COMPLETE!!" -ForegroundColor Green
            }
            False { Write-Host "checker complete but not compressed" -ForegroundColor Red }
            Default { Write-Host "checker complete but not compressed" -ForegroundColor Red }
        }    
    }
    switch (Read-Host "Start CHECKER??(Y/n)") {
        "y" { checkerPS1 }
        "n" { Write-Host "not start" -ForegroundColor Yellow }
        Default { checkerPS1 }
    }
} # end checker
function viewcheck {   
    $file = ((Get-ChildItem ("$env:USERPROFILE") |Where-Object Extension -EQ ".zip" | Sort-Object -Property LastWriteTime -Descending | Select-Object FullName ).FullName)
    $newname = $file.split(".")[0]
    Expand-Archive -Path $file -DestinationPath $newname
    cd $newname 
    cd $newname
} # end viewcheck

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
        
    function commandip{
        switch (Read-Host "ICANN OR IPRESOLVER") {
            "icann" { myip1 | Out-GridView }
            "ipresolver" { myip2 | Out-GridView }
            exit{exit}
            Default {
                [ordered]@{
                    "ipresolver" = "myip.opendns.com","resolver1.opendns.com"
                    "icann" = "http://icanhazip.com/"
                    "exit" = break
                }
            }
        }
    }
    while (1) {
        commandip
    }
} # end ipview

function updateconsole{
    Invoke-Expression (new-object net.webclient).downloadstring("https://raw.githubusercontent.com/Krip4us/POWERSHELL/master/Interactive%20Console.ps1") -Verbose
}

function removecheckers {
    $rootPath = $env:USERPROFILE
    (Get-ChildItem $rootPath | Where-Object name -Match "$env:COMPUTERNAME;INFO;" | Select-Object FullName) | ForEach-Object{
        Remove-Item $_.FullName -Recurse -Force -Verbose -Confirm:$true
    }
} # end removecheckers

function commands{
    Write-Host "__________________________________________________________________"
    Write-Host "AUTHOR      : krip4us@github.com" -ForegroundColor Green 
    Write-Host "NAME        : interactive console for starting powershel" -ForegroundColor Red
    Write-Host "NAME PS1    : profile.ps1" -ForegroundColor Red
    Write-Host "EXTENSION   : .ps1 (PowerShell Script)" -ForegroundColor Blue
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
        "viewcheck" = "view the last checker file compressed"
        "removecheckers" = "remove all last checker files"
        "ipview" = "see ip public"
        "updateconsole" = "update interactive console"
    }
} # end commands 
