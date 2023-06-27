param (
    [Parameter(Mandatory=$true, Position=0)]
    [Alias("d", "dir", "directory")]
    [string]$directoryName
)

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $directoryName -PathType Container)) {
    New-Item -ItemType Directory -Name $directoryName -Path "./" -ErrorAction SilentlyContinue | Out-Null
} else {
    Write-Host "The directory '$directoryName' already exists."
    return
}

Set-Location $directoryName


