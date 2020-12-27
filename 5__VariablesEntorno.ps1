ls env:

#Se pueden crear variables de entorno de la siguiente forma
    $env:TestVariable = "mi propia env variable"
    Get-ChildItem Env:\TestVariable
    Remove-Item Env:\TestVariable

    $variableproce=ps
    $variableproce | Get-Member

    #Crear un objeto coche con propiedades
    #Clase coche con propiedades
    class Coche
    { 
    $Marca
    $Modelo
    $FechaCompra
    $Color
    }
    
#Crear objeto coche de la clase Coche
    $coche=New-Object -TypeName Coche
    $coche.Marca = read-host "MARCA"
    $coche.Modelo = read-host "MODELO"
    $coche.Color = read-host "COLOR"
    $coche.FechaCompra= Get-Date -format u
    ($coche | format-custom )


#Crear un objeto coche con propiedades y objetos
    $coche = New-Object Object
    $coche | Add-Member ScriptMethod color {
        "ROJO"
    }
    $coche | Add-Member ScriptMethod TemperaturaMotor {
        "140"
    }
    $coche.color()
    $coche.TemperaturaMotor()
    $coche | Get-Member


<#
En PowerShell se pueden crear clases y de las clases crear objetos.
En las clases se pueden definir además de lo dicho anteriormente también se pueden crear constructores dentro de las clases.
#>
