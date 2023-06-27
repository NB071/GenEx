param (
    [Parameter(Mandatory = $true, Position = 0)]
    [Alias("d", "dir", "directory")]
    [string]$directoryName,
    [Parameter(Mandatory = $false, Position = 1)]
    [Alias("t", "temp", "template")]
    [ValidateSet("ts", "js")]
    [string]$templateExtension = "js"
)

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $directoryName -PathType Container)) {
    Write-Host "[*] Creating directory => $directoryName"
    New-Item -ItemType Directory -Name $directoryName -Path "./" | Out-Null
    Write-Host "[+] Directory ($directoryName) Created Successfully.`n"
}
else {
    Write-Host "[-] Directory ($directoryName) already exists!"
    return
}

Set-Location $directoryName

# Create package.json file
Write-Host "[*] Creating file => package.json"
Invoke-Expression -Command "npm init -y" | Out-Null
Write-Host "[+] File (package.json) Created Successfully.`n"

# Create configs directory
Write-Host "[*] Creating directory => configs"
New-Item -ItemType Directory -Name "configs" -Path "./" | Out-Null
Write-Host "[+] Directory (configs) Created Successfully.`n"

# Place files for configs directory
Set-Location "./configs"

Write-Host "[*] Creating file => db.$templateExtension"
New-Item -ItemType File -Name "db.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (db.$templateExtension) Created Successfully.`n"

Write-Host "[*] Creating file => mail.$templateExtension"
New-Item -ItemType File -Name "mail.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (mail.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Create controllers directory
Write-Host "[*] Creating directory => controllers"
New-Item -ItemType Directory -Name "controllers" -Path "./" | Out-Null
Write-Host "[+] Directory (controllers) Created Successfully.`n"

# Place files for controllers directory
Set-Location "./controllers"
Write-Host "[*] Creating file => appController.$templateExtension"
New-Item -ItemType File -Name "appController.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (appController.$templateExtension) Created Successfully.`n"

Set-Location ".."


# Create middlewares directory
Write-Host "[*] Creating directory => middlewares"
New-Item -ItemType Directory -Name "middlewares" -Path "./" | Out-Null
Write-Host "[+] Directory (middlewares) Created Successfully.`n"

# Place file(s) for middlewares directory
Set-Location "./middlewares"
Write-Host "[*] Creating file => auth.$templateExtension"
New-Item -ItemType File -Name "auth.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (auth.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Create models directory
Write-Host "[*] Creating directory => models"
New-Item -ItemType Directory -Name "models" -Path "./" | Out-Null
Write-Host "[+] Directory (models) Created Successfully.`n"

# Place sub-directories for models
Set-Location "./models"

# Place models/migration sub-directory
Write-Host "[*] Creating directory => models/migrations"
New-Item -ItemType Directory -Name "migrations" -Path "./" | Out-Null
Write-Host "[+] directory (models/migrations) Created Successfully.`n"

# Place models/seeds sub-directory
Write-Host "[*] Creating directory => models/seeds"
New-Item -ItemType Directory -Name "seeds" -Path "./" | Out-Null
Write-Host "[+] directory (models/seeds) Created Successfully.`n"

Set-Location ".."

# Create routes directory
Write-Host "[*] Creating directory => routes"
New-Item -ItemType Directory -Name "routes" -Path "./" | Out-Null
Write-Host "[+] Directory (routes) Created Successfully.`n"

# Place /routes/v1 sub-directory
Set-Location "./routes"
Write-Host "[*] Creating directory => routes/v1"
New-Item -ItemType Directory -Name "v1" -Path "./" | Out-Null
Write-Host "[+] directory (routes/v1) Created Successfully.`n"

# Place sample file(s) into routes/v1
Set-Location "./v1"
Write-Host "[*] Creating file => app.$templateExtension"
New-Item -ItemType File -Name "app.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (app.$templateExtension) Created Successfully.`n"

Set-Location "../.."

# Create utils directory
Write-Host "[*] Creating directory => utils"
New-Item -ItemType Directory -Name "utils" -Path "./" | Out-Null
Write-Host "[+] Directory (utils) Created Successfully.`n"

# Place file(s) for utils directory
Set-Location "./utils"
Write-Host "[*] Creating file => cronJobs.$templateExtension"
New-Item -ItemType File -Name "cronJobs.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (cronJobs.$templateExtension) Created Successfully.`n"

Write-Host "[*] Creating file => randomJWTKey.$templateExtension"
New-Item -ItemType File -Name "randomJWTKey.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (randomJWTKey.$templateExtension) Created Successfully.`n"

Set-Location ".."

# Create public directory
Write-Host "[*] Creating directory => public"
New-Item -ItemType Directory -Name "public" -Path "./" | Out-Null
Write-Host "[+] Directory (public) Created Successfully.`n"

# Place sub-directories for public
Set-Location "./public"

# Place public/images sub-directory
Write-Host "[*] Creating directory => public/images"
New-Item -ItemType Directory -Name "images" -Path "./" | Out-Null
Write-Host "[+] directory (public/images) Created Successfully.`n"

# Place public/videos sub-directory
Write-Host "[*] Creating directory => public/videos"
New-Item -ItemType Directory -Name "videos" -Path "./" | Out-Null
Write-Host "[+] directory (public/videos) Created Successfully.`n"

Set-Location ".."


# Create Index.js/ts
Write-Host "[*] Creating file => index.$templateExtension"
New-Item -ItemType File -Name "index.$templateExtension" -Path "./" | Out-Null
Write-Host "[+] File (index.$templateExtension) Created Successfully.`n"

# create .env file
Write-Host "[*] Creating file => .env"
New-Item -ItemType File -Name ".env" -Path "./" | Out-Null
Write-Host "[+] File (.env) Created Successfully.`n"

# create .env-sample file
Write-Host "[*] Creating file => .env-sample"
New-Item -ItemType File -Name ".env-sample" -Path "./" | Out-Null
Write-Host "[+] File (.env-sample) Created Successfully.`n"

# create README file
Write-Host "[*] Creating file => README.md"
New-Item -ItemType File -Name "README.md" -Path "./" | Out-Null
Write-Host "[+] File (README.md) Created Successfully.`n"

# init git
Write-Host "[*] Initializing => Git"
Invoke-Expression -Command "git init" | Out-Null
New-Item -ItemType File -Name ".gitignore" -Path "./" | Out-Null
Write-Host "[+] Git Initialized Successfully.`n"