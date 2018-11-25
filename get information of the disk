'''powershell
$my_disk = %{
get-wmiobject win32_volume -computername . | select name, @{expression={$_.capacity/1GB}}, @{expression={$_.freespace/1GB}}, @{name=”% Free”;expression={$_.freespace/$_.capacity*100}}
}
$my_disk
$my_disk | Out-File resltados.txt -Append

'''
