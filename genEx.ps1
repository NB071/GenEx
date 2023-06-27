param (
    [Parameter(Mandatory = $true, Position = 0)]
    [Alias("d", "dir", "directory")]
    [string]$directoryName
)

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $directoryName -PathType Container)) {
    Write-Host "[*] Creating directory => '$directoryName' "
    New-Item -ItemType Directory -Name $directoryName -Path "./" | Out-Null
    Write-Host "[+] Directory ('$directoryName') Created Successfully.`n"
}
else {
    Write-Host "[-] Directory ('$directoryName') already exists!"
    return
}

Set-Location $directoryName

# Create package.json file
Write-Host "[*] Creating file => package.json"

Invoke-Expression -Command "npm init -y" | Out-Null

Write-Host "[+] File (package.json) Created Successfully.`n"

# init git
Write-Host "[*] Initializing => Git"

Invoke-Expression -Command "git init" | Out-Null
New-Item -ItemType File -Name ".gitignore" -Path "./" | Out-Null

Write-Host "[+] Git Initialized Successfully.`n"







# create README file
Write-Host "[*] Creating file => README.md"

New-Item -ItemType File -Name "README.md" -Path "./" | Out-Null

Write-Host "[+] File (README.md) Created Successfully.`n"