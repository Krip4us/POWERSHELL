$arraynumeros="12345"
Write-Host $arraynumeros
Write-Host $arraynumeros[0]


#Mostrar cada uno de los elemntos de los caracteres
"PowerShell"|%{
    for ($i=0;$i -lt $_.Length; ++$i) { 
        $_[$i] 
    }
}


#Mostrar el valor entero de cada uno de los elementos de un array de caracteres
    [string]$a="En cierto lugar de la mancha"
    for($i=0; $i -lt $a.Length; $i=$i+1){
        ([int]$a[$i])
    }


#Convertir una cadena en mayúsculas
    'Hola'.ToUpper()
#Convertir una cadena en minisculas
    'HOLA'.ToLower()
#Convertir la primera letra de una palabra en mayúscula
    $palabra="palabra"
    $palabra.substring(0,1).toupper()+$palabra.substring(1).tolower()


#Eliminar caracteres que no sean alfabéticos y conservar los caracteres que tengan acentos
    $cadena = 'áéíóúabcdefg12345HIJKLMNOP!@#$%qrs)(*&^TUVWXyz'
    $patron = '[^a-zA-Zá-úÁ-Ú]'
    $cadena -replace $patron, ''


#Dividir en grupos de cinco elementos una cadena
    '1234512345123451234512345123451234512345' -split '(?<=\G\d{5})(?=.)'


#Eliminar espacios de una frase
    ' Hola buenas '.TrimStart()
    'Hola buenas '.TrimEnd()
    ' Hola buenas '.Trim()


#Reducir texto con puntos suspensivos
    $LongitudMax = 10
    $Texto = 'Texto para acortar'

    if ($Texto.Length -gt $LongitudMax)
    {
    $Texto.Substring(0,$LongitudMax) + '...'
    }
    else
    {
    $Texto
    }


#Insertar un elemento en una posición de la una palabra
    'Hola'.Insert(1, "oooo")


#Determinar la posición de un carácter dentro de una palabra
    'Holasa'.IndexOf('s')
#Determinar la ultima posición de un carácter dentro de una palabra
    'Holasa'.LastIndexOf('a')
#Saber si el principio de una palabra comienza con un carácter
    'Holalalalalla'.StartsWith('Hola')
#Saber si el final de una palabra finaliza con un carácter
    'cerrokamokala'.EndsWith('kala')
#Buscar una cadena
    'Hola'| Select-String 'o'