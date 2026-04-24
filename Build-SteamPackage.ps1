[CmdletBinding()]
param(
    [string]$OutputDir = 'dist\MagicPockets-Steam'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = $PSScriptRoot
$outputPath = Join-Path $projectRoot $OutputDir

$requiredPaths = @(
    'Launch-MagicPockets.cmd',
    'Launch-MagicPockets.ps1',
    'config\MagicPockets.uae',
    'game\disks\MagicPockets.adf',
    'roms\kick13.rom'
)

foreach ($required in $requiredPaths) {
    $fullPath = Join-Path $projectRoot $required
    if (-not (Test-Path $fullPath)) {
        throw "Required file missing: $required"
    }
}

$winuaeFolder = Join-Path $projectRoot 'winuae'
$winuaeExeCount = (Get-ChildItem -Path $winuaeFolder -Filter 'winuae*.exe' -ErrorAction SilentlyContinue).Count
if ($winuaeExeCount -eq 0) {
    throw 'No WinUAE executable found in winuae folder.'
}

if (Test-Path $outputPath) {
    Remove-Item -Path $outputPath -Recurse -Force
}

New-Item -ItemType Directory -Path $outputPath | Out-Null

$copyItems = @('Launch-MagicPockets.cmd', 'Launch-MagicPockets.ps1', 'config', 'game', 'roms', 'winuae')
foreach ($item in $copyItems) {
    Copy-Item -Path (Join-Path $projectRoot $item) -Destination $outputPath -Recurse -Force
}

Write-Host "Steam package staged at: $outputPath"
