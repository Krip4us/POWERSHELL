$hash = @{
    a = 2
    b = 4
    c = 6
}
$hash.add('d',8)
$hash.Keys | foreach-object { "key = $_ , value = " + $hash.Item($_) }


# Crear enumeraciones
enum Ciudades
{
    Hannover
    Madrid
    Seattle
    Barcelona
    London
    NewYork
}

function Seleccion-Ciudades
{
    param ([Ciudades][Parameter(Mandatory=$true)]$Ciudad)
    Write-Host "Has elegido la ciudad de $Ciudad"
}

Seleccion-Ciudades 3

#Crear el juego de piedra, papel o tijera utilizando enumeraciones para las combinaciones posibles
    enum PPT{
        Piedra = 1
        Papel = 2 
        Tijera = 3
    }
    enum Combinacion
    {
        EmpatePiedra = 11
        EmpatePapel = 22
        EmpateTijera = 33
        GanaPiedra = 13
        GanaPapel = 21
        GanaTijera = 32
        PierdePiedra = 12
        PierdePapel = 23
        PierdeTijera = 31
        
    }
    $jugador1 = random(1..3); [PPT]$jugador1
    $jugador2 = random(1..3); [PPT]$jugador2
    [Combinacion](
        [String]$jugador1 + [String]$jugador2
    )
    [Combinacion](
        [String]$jugador2 + [String]$jugador1
    )


#CREAR CLASES DE OBJETOS DENTRO DE VARIABLES
        class Coche
        { 
        $Marca
        $Modelo
        $FechaCompra
        $Color
        }
        $coche = New-Object -TypeName Coche
    #Añadir propiedades del coche
        $coche.Marca="Audi"
        $coche.Modelo="A2"
        $coche.Color="Rojo"
        $coche.FechaCompra= Get-Date
    #Mostrar el color del coche
        $coche.Color ; $coche | select color
    #Mostrar información sobre el coche
        $coche