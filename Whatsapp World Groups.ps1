$url = "https://web.archive.org/cdx/search?url=https%3A%2F%2Fchat.whatsapp.com%2F&matchType=prefix&collapse=urlkey&output=json&fl=original%2Cmimetype%2Ctimestamp%2Cendtimestamp%2Cgroupcount%2Cuniqcount&filter=!statuscode%3A%5B45%5D..&limit=100000&_=15336515"

$contenido = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
$json = $contenido | ConvertFrom-Json
$json.SyncRoot | ForEach-Object{$_[0]}

<# FIN DEL SCRIPT DE WHATSAPP_GroUps
.AUTHOR = krip4Us@github.com
#>
