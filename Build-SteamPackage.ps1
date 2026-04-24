[CmdletBinding()]
param(
    [string]$OutputDir = 'dist\Steam-WinUAE'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = $PSScriptRoot
$outputPath = Join-Path $projectRoot $OutputDir

$requiredPaths = @(
    'config\MagicPockets.uae',
    'game\disks\MagicPockets.adf',
    'roms\kickstart-1.3.rom',
    'winuae\winuae64.exe',
    'Launch-MagicPockets.bat',
    'README-Steam.txt'
)

foreach ($required in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $required
    if (-not (Test-Path $fullPath)) {
        throw "Required file missing: $required"
    }
}

if (Test-Path $outputPath) {
    Remove-Item -Path $outputPath -Recurse -Force
}

New-Item -ItemType Directory -Path $outputPath | Out-Null

Copy-Item -Path (Join-Path $projectRoot 'winuae\winuae64.exe') -Destination (Join-Path $outputPath 'winuae64.exe') -Force
Copy-Item -Path (Join-Path $projectRoot 'roms\kickstart-1.3.rom') -Destination (Join-Path $outputPath 'kickstart-1.3.rom') -Force
Copy-Item -Path (Join-Path $projectRoot 'game\disks\MagicPockets.adf') -Destination (Join-Path $outputPath 'magicpockets.adf') -Force
Copy-Item -Path (Join-Path $projectRoot 'game\disks\MagicPockets-Plus4.adf') -Destination (Join-Path $outputPath 'magicpockets-plus4.adf') -Force
Copy-Item -Path (Join-Path $projectRoot 'game\disks\MagicPockets-SKR.adf') -Destination (Join-Path $outputPath 'magicpockets-skr.adf') -Force
Copy-Item -Path (Join-Path $projectRoot 'Launch-MagicPockets.bat') -Destination (Join-Path $outputPath 'Launch-MagicPockets.bat') -Force
Copy-Item -Path (Join-Path $projectRoot 'README-Steam.txt') -Destination (Join-Path $outputPath 'README-Steam.txt') -Force

$configContent = Get-Content -Path (Join-Path $projectRoot 'config\MagicPockets.uae')
$configContent = $configContent -replace '^kickstart_rom_file=.*$', 'kickstart_rom_file=kickstart-1.3.rom'
$configContent = $configContent -replace '^floppy0=.*$', 'floppy0=magicpockets.adf'
Set-Content -Path (Join-Path $outputPath 'magicpockets_steam.uae') -Value $configContent -Encoding ascii

$sourceIni = Join-Path $projectRoot 'winuae\winuae.ini'
if (Test-Path $sourceIni) {
    Copy-Item -Path $sourceIni -Destination (Join-Path $outputPath 'winuae.ini') -Force
}

Write-Host "Steam package staged at: $outputPath"
