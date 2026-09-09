$webhook = 'https://webhook.site/3fa59b0e-4157-4c9e-a72b-4803657bd464'
$path = "$env:USERPROFILE\Desktop\PICO2W_TEST"

# Crear carpeta
if (!(Test-Path -LiteralPath $path)) {
    New-Item -Path $path -ItemType Directory | Out-Null
}

$fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Crear archivos de prueba
"PRUEBA PICO 2 W" | Set-Content "$path\resultado.txt"
"Fecha: $fecha" | Add-Content "$path\resultado.txt"
"Resultado: EJECUCIÓN CORRECTA" | Add-Content "$path\resultado.txt"

"OK" | Set-Content "$path\OK.txt"

"Archivo creado por la prueba del Pico 2 W" |
    Set-Content "$path\Funciona.txt"

# Comprobar archivos
$archivos = Get-ChildItem -LiteralPath $path -File

"Archivos encontrados: $($archivos.Count)" |
    Add-Content "$path\resultado.txt"

foreach ($archivo in $archivos) {
    "$($archivo.Name) - $($archivo.Length) bytes" |
        Add-Content "$path\resultado.txt"
}

# Prueba del Webhook
$mensaje = "PICO2W_TEST_OK | $fecha"

try {
    Invoke-WebRequest `
        -UseBasicParsing `
        -Uri $webhook `
        -Method POST `
        -Body $mensaje `
        -ErrorAction Stop | Out-Null

    "Webhook: OK" | Add-Content "$path\resultado.txt"
}
catch {
    "Webhook: ERROR" | Add-Content "$path\resultado.txt"
}

# Mostrar resultado
Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show(
    "PICO 2 W: prueba completada.`n`nArchivos creados: $($archivos.Count)`nWebhook probado correctamente.",
    "Pico 2 W - TEST"
)
