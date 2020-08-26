
function info {
    [pscustomobject]@{
        'AUTOR' = 'https://github.com/Krip4us'
        'NOMBRE DEL PROGRAMA' = 'CHECK1ER.ps1'
        'version' = '3.0.0.0'
        'PERTENENCIA' = 'SPARTAN TECHNOLOGY'
        'DOMINIO' = 'spartan.tech'
    }   |Out-GridView 
}

function  check1 {

    cd $env:HOMEPATH
    Write-Warning '$PSVersionTable.PSVersion -gt 5.0.0'
    $random = Get-Random -Maximum 100 -Minimum 1 
    Write-Host $random -ForegroundColor Red
    New-Item -ItemType Directory -Name "$env:COMPUTERNAME;INFO;$random" -ErrorAction SilentlyContinue ; cd "$env:COMPUTERNAME;INFO;$random"

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
        "-------------------------------------------"
        systeminfo.exe | Out-File systeminfo.sys -Verbose
        "-------------------------------------------"
        Get-PSDrive | Where-Object Root -NotLike $null | Out-File PSDrive.sys -Verbose
        "-------------------------------------------"
        Get-Process | Out-File Process.sys -Verbose
        "-------------------------------------------"
        Get-PnpDevice | Where-Object Status -EQ OK | Group-Object -Property class | Out-File PnpDevice.sys -Verbose
        "-------------------------------------------"
        Get-Disk | Out-File Disk.sys -Verbose
        "-------------------------------------------"
        Get-NetTCPConnection | Select-Object * | Format-List | Out-File NetTCPConnection.sys -Verbose
        "-------------------------------------------"
        $wc = new-object System.Net.Webclient
        $wc.DownloadString("http://icanhazip.com/") | Out-File IPv4_Public.sys -Verbose
        "-------------------------------------------"
        nslookup myip.opendns.com resolver1.opendns.com | Out-File NsLookup.sys -Verbose
        "-------------------------------------------"
        ipconfig.exe /displaydns | Out-File displaydns.sys -Verbose
        "-------------------------------------------"
        Get-NetAdapterBinding -Name *  | Sort-Object -Property Enabled -CaseSensitive | Group-Object -Property DisplayName | Select-Object Name,Group | Out-File Get-NetAdapterBinding.sys -Verbose
        "-------------------------------------------"
        Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\*\*\' | Where-Object { $_.FriendlyName } | Select-Object FriendlyName | Out-File USBSTOR.sys -Verbose
        "-------------------------------------------"
        whoami /all | out-file whoami.sys -Verbose
        "-------------------------------------------"
        wbadmin get versions | out-file DiskVersions.sys -Verbose
        "-------------------------------------------"
        route print | Out-File rote.print.sys -Verbose
        "-------------------------------------------"
        function netstat_get_info{
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
    
                function removelength0{
                    ($netstatlength) | ForEach-Object{
                        if ( (($_.name).Count) -gt 0 ) {
                            rm $_.name -Verbose
                        }
                        elseif ( (($_.name).Count) -eq 0 ){
                            Write-Host "no files with length 0" -ForegroundColor Green
                        }
                        else {
                            Write-Warning "cannot remove files with length 0, sorry"
                        }
                    }
                }
    
                fUnction netstatlog{
                    [pscustomobject]@{
                        "exist" = $netstatcoUnt
                        "filesLength0" = $netstatlengthcontentcoUnt
                    }|Format-List
                }
    
                netstatlog | Out-File "system.Windows.Netstat.Log" ; removelength0
    
                    cd ..
    
        }
        "-------------------------------------------"
        ([System.Security.Principal.WindowsIdentity]::GetCurrent()).name | Out-File CurrentUser.sys
        "-------------------------------------------"
    }
      
    #################
    Check ; 
    #################

    Set-Location ..;
    Compress-Archive -Path  "$env:COMPUTERNAME;INFO;$random" -DestinationPath  "$env:COMPUTERNAME;INFO;$random.zip";
    if ((Test-Path "$env:COMPUTERNAME;INFO;$random.zip")-eq 'True') {
        rmdir "$env:COMPUTERNAME;INFO;$random" -Recurse -Force;
        
    '________________________________________________________________________________________________'
    Write-Host "CHECKER FINISH COMPLETE!!" -ForegroundColor Green
    '________________________________________________________________________________________________'
}
    else {
        Write-Host "checker completed, but not compressed"
    }
}
check1
