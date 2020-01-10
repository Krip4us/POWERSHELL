$users = "user1","user2"
$pass = "pass1","pass2"

function passwd {
    $paswdpath = '$.sql.users'
    $paswd = Read-Host "pass"

    if ($pass -contains $paswd) {
        Test-Path $paswdpath|%{
            if ($_ -eq 'False') {
                mkdir $paswdpath
            }
            else {
                cd $paswdpath
            }
        }
    }
    else {
        Write-Host "error" -ForegroundColor Red
    }
}
function login {

    $read = Read-Host "user"
    if ($users -contains $read) {
        
        Test-Path $read |%{
            if ($_ -eq "False") {
                ni -ItemType Directory -Name $read;cd $read
                passwd
            }
            else {
                passwd
            }
        }
    }
    else {
        Write-Host "error" -ForegroundColor Red
    }
}
login
