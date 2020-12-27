#Representan el valor verdadero (1) o falso (0).
    $true ; $false
    $bool = $true ; $bool

#Fechas
    [datetime]'12/22/2016 00:00'
    (Get-Date).Year.tostring()+(Get-Date).Month.tostring()+(Get-Date).Day.tostring()
    Get-TimeZone -ListAvailable
    #fecha anterior
    (Get-Date).AddDays(-1)
    #Semana anterior
    -1..-7 | % {(Get-Date).AddDays($_).ToString("dd/MM/yyyy")}
    #Calcular el día de la semana para una fecha
    (Get-Date).AddDays(-((get-date)-([datetime]'12/22/2016 00:00')).Days).DayOfWeek
    #Variables de tiempo
    New-TimeSpan $(Get-Date) $(Get-Date -month 7 -day 19 -year 2016)
    #Ver la diferencia horaria que hay entre España y Nueva Zelanda
    ((Get-Date)-([TimeZoneInfo]::ConvertTime((Get-Date),[TimeZoneInfo]::FindSystemTimeZoneById("New Zealand Standard Time")))).Hours
    