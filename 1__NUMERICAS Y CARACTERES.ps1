[Int]$num=5
$num
$num.GetType()

[char]$numChar=1
$numChar.GetType()

#Crear una variable con el valor 20 indicando el tipo entero para una de las variables y el tipo carácter para la otra, después ver el contenido y comprobar el tipo después
    [int]$cantidad=20
    Write-Host $cantidad
    $cantidad.GetType()

    [string]$cantidad2=20
    Write-Host $cantidad2
    $cantidad2.GetType()


#CARACTERES#
#Mostrar todos los números del 0 al 9 como caracteres
    48..57 | %{
        [char]$_
    }


#Mostrar todas las letras mayúsculas
    [char]'A'..[char]'Z' | %{[char]$_}
    65..90 | %{[char]$_}


#Mostrar todas las letras minúsculas
    [char]'a'..[char]'z' | %{[char]$_}
    97..122 | %{[char]$_}


#Mostrar todos los caracteres ASCII
    0..255 | %{Write-Host ([char]$_ +" ") -NoNewline}


#Mostrar todos los caracteres Base64
    #Array que va a contener todos los caracteres en Base64
    $arrayBase64=""
    #Añadir al array las mayúsculas
    $arrayBase64+=[char]'A'..[char]'Z' | %{[char]$_}
    #Añadir al array las minúsculas
    $arrayBase64+=[char]'a'..[char]'z' | %{[char]$_}
    #Añadir al array los números
    $arrayBase64+=[char]'0'..[char]'9' | %{[char]$_}
    #Añadir al array el carácter + y /
    $arrayBase64+="+"
    $arrayBase64+="/"
    #Quitar los espacios del array
    $arrayBase64=$arrayBase64-replace " "
    #Mostrar los caracteres
    $arrayBase64
    #Número de caracteres en Base64
    $arrayBase64.Length
    #Primer carácter
    $arrayBase64[0]
    #Último carácter
    $arrayBase64[$arrayBase64.Length-1]
