#Ver las actualizaciones instaladas en el sistema
Get-HotFix | Select-Object HotFixID
Get-Package | Select-Object Name | Where-Object Name -match "Actualización" | Format-Custom
