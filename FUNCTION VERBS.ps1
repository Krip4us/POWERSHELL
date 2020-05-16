function verbos{
    [PSCustomObject]@{
    #esta es la lista completa qUe se entiende como
    #infinitivo     P.S     P.P     TRADCUCCIÓN  
        'slide' = 'slid' , 'slid' , 'resbalar'
        'smell' = 'smelt' , 'smelt' , 'oler'
        'sow' = 'sowed' , 'sowed' , 'sembrar'
        'speak' = 'spoke' , 'spoken' , 'hablar'
        'speed' = 'sped' , 'sped' , 'acelerar'
        'spell' = 'spelt' , 'spelt' , 'deletrear'
        'spend' = 'spent' , 'spent' , 'gastar'
        'spill' = 'spilt' , 'spilt' , 'derramar'
        'spin' = 'spun' , 'spun' , 'hilar'
        'spit' = 'spat' , 'spat' , 'escupir'
        'split' = 'split' , 'split' , 'partir'
        'spoil' = 'spoilt' , 'spoilt' , 'estropear'
        'spread' = 'spread' , 'spread' , 'extender'
        'spring' = 'sprang' , 'sprung' , 'saltar'
        'stand' = 'stood' , 'stood' , 'estar en pie'
    }
}

while(1){
    #listamos todos los verbos q en total son 15
    $todos = ((verbos | Get-Member))[4..19] # del member 4 qUe es el primer verbo al 19 qUe es el Ultimo
    $num = Get-Random -Minimum 0 -Maximum 14 # nUmero aleatorio qUe indicara el verbo qUe pregUntara
    
    $todosName = $todos.Name #seleccionamos el objeto nombre qUe hace referencia al verbo en infinitivo
    $verb = $todosName[$num] #seleccionamos el verbo qUe vamos ha pregUntar

    #cada resultado se guarda en una varible llamado "col" que hace referencia a cada columna
    $darch = ((verbos | Select-Object $verb).$verb)
    $col1 = $darch[0] # past simple
    $col2 = $darch[1] #past participle
    $col3 = $darch[2] # tradUcción

    #pregUntas 
    $preguntatacol1 = Read-Host "$verb(pasado simple)"
    $preguntatacol2 = Read-Host "$verb(participio pasado)"
    $preguntatacol3 = Read-Host "$verb(traduccion)"

    #respUestas // CADA RESPUSTA SE GUARDA EN UN FICHERO LLAMADO -> reslt.txt
    if ("$preguntatacol1" -eq "$col1") {
        $WRITEcol1 = Write-Host "[OK]   pasado simple de $verb" -ForegroundColor Green
        "
        [OK]   pasado simple de $verb" >> reslt.txt
    }
    else {
        $WRITEcol1 = Write-Host "[BAD]   pasado simple de $verb ES $col1" -ForegroundColor Red
        "
        [BAD]   pasado simple de $verb ES $col1" >> reslt.txt
    }

    if ("$preguntatacol2" -eq "$col2") {
        $WRITEcol2 = Write-Host "[OK]   participio pasado de $verb" -ForegroundColor Green
        "
        [OK]   participio pasado de $verb" >> reslt.txt
    }
    else {
        $WRITEcol2 = Write-Host "[BAD]   participio pasado de $verb ES $col2" -ForegroundColor Red
        "
        [BAD]   participio pasado de $verb ES $col2" >> reslt.txt
    }

    if ("$preguntatacol3" -eq "$col3") {
        $WRITEcol3 = Write-Host "[OK]   traduccion de $verb" -ForegroundColor Green
        "
        [OK]   traduccion de $verb" >> reslt.txt
    }
    else {
        $WRITEcol3 = Write-Host "[BAD]   traduccion de $verb ES $col3" -ForegroundColor Red
        "
        [BAD]   traduccion de $verb ES $col3"  >> reslt.txt
    }
}
<# FIN DEL SCRIPT DE VERBOS
.AUTHOR = krip4Us@github.com
#>
