$usuario = Read-Host "Introduzca usuario: "
if ($usuario -eq 'hola'){
Write-Warning "acceso concedido"
}

else {
Write-Warning ("Access denied.")
Write-Warning ("YOU DON'T HAVE PERMISSION.")
Start-Sleep -Seconds (10)
cd C:\Users\Admin\acsdenied
gc .\readme.txt 
}

if ($usuario -eq 'hola'){
$pwd = Read-Host "Introduzca password: "
if ($pwd -eq 'adios'){
Write-Warning "acceso concedido"
Write-Host "ACCEDIENDO A LA BASE DE DATOS"
Start-Sleep -Seconds (3)
Write-Warning "VERIFICANDO RED SEGURA..."
cd 'C:\$.setSQL@adm--)'
Start-Sleep -Seconds (2)

$kuser = Read-Host "¿QUE USUARIO ERES?: "
if($kuser -eq 1){
cd 'C:\$.setSQL@adm--)\1'
}

if($kuser -eq 2){
cd 'C:\$.setSQL@adm--)\2'
}

if($kuser -eq 3){
cd 'C:\$.setSQL@adm--)\3'
}
}
}
else {
Write-Warning ("Access denied.")
Write-Warning ("YOU DON'T HAVE PERMISSION.")
Start-Sleep -Seconds (10)
cd C:\Users\Admin\acsdenied
gc .\readme.txt 

}
