FUNCTION CREATE{
function Get_Random{"asusyvits"+(Get-Random -Maximum 10 -Minimum 0)}
    $numero = Get_Random
        Get_Random >> users.usr
            $checkususario = ((gc .\users.usr)-match "$numero")
                $checker = (Get-LocalUser | select name).name -contains "$checkususario"
                $usek = ((Get-LocalUser | select name).name)
                $user = $checkususario[0]

                    if($usek -contains $checkususario[0]){Write-Host "user exist, continue" -ForegroundColor Green}
                    else{New-LocalUser -Name "$user" -AccountNeverExpires -Description "usuarios de serv-cuentas" -FullName "ASUSYRED\$checkususario" -NoPassword -Verbose}
}

Get-LocalUser | Where-Object name -NotMatch $env:USERNAME | select * | Format-List | Out-File "$env:COMPUTERNAME;$env:USERNAME;Users"
$group = (Get-LocalGroup | Where-Object name -Match "Usuarios" | select Name).name[0]
$members = Get-LocalUser | Where-Object name -NotMatch $env:USERNAME | select Name
    Add-LocalGroupMember -Member (($members).name -match "asusyvits") -Group $group
    Get-LocalGroupMember -Group $group | select * | Format-List | Out-File "$env:COMPUTERNAME;$env:USERNAME;Members"

$usr = (Get-LocalUser | Where-Object name -Match asusyvits | select name)
    if(($usr.Count -lt 10)-eq "True" ){CREATE ; $UsersCreate="False"}
    else{Write-Host "USERS WAS CREATED" -ForegroundColor Green ; $UsersCreate = "True"}
    while($UsersCreate -eq "False"){CREATE}
    Start-Sleep -Seconds 7
    break

'_______________________________________________________________________________________________'
<#REMOVE USERS
$usr = (Get-LocalUser | Where-Object name -Match asusyvits | select name)
Remove-LocalUser -Name $usr.name
#>
