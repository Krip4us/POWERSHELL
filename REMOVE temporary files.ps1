Start-Process powershell{
(ls $env:TEMP | Select-Object FullName) | ForEach-Object{
  rm $_.FullName -Recurse -Force <# OPCIONAL: -Confirm:$false -Verbose:$true #>}
}-verb runas

<# FIN DEL SCRIPT: REMOVE TEMP FILES 
.AUTHOR = krip4Us@github.com
#>
