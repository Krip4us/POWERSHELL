# Name the server where this needs to be run
$ServerName = 'localhost'
 
# Check Total Capacity of the Drive
$TCapacity =
@{
    Expression = { "{0,19:n2}" -f ($_.Capacity / 1GB) };
    Name       = 'Total Capacity (GB)';
}
 
# Freespace to be displayed in GB
$Freespace =
@{
    Expression = { "{0,15:n2}" -f ($_.FreeSpace / 1GB) };
    Name       = 'Free Space (GB)';
}
 
# Percentage value of the free space
$PercentFree =
@{
    Expression = { [int]($_.Freespace * 100 / $_.Capacity) };
    Name       = 'Free (%)'
}
# Calculation
Get-WmiObject -namespace "root/cimv2" -computername $ServerName -query "SELECT Name, Capacity, FreeSpace FROM Win32_Volume WHERE Capacity > 0 and (DriveType = 2 OR DriveType = 3)" | 
Select-Object -Property Name, $TCapacity, $Freespace, $PercentFree  | Sort-Object 'Free (%)' -Descending
