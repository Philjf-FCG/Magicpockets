[CmdletBinding()]
param(
    [ValidateSet('CSL', 'CSLTrainer', 'SKR')]
    [string]$Variant = 'SKR',
    [switch]$Windowed
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = $PSScriptRoot
$configPath = Join-Path $projectRoot 'config\MagicPockets.uae'

$romCandidates = @(
    Join-Path $projectRoot 'roms\kickstart-1.3.rom'
    Join-Path $projectRoot 'roms\kick13.rom'
)
$romPath = $romCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1

$diskMap = @{
    CSL = 'game\disks\MagicPockets.adf'
    CSLTrainer = 'game\disks\MagicPockets-Plus4.adf'
    SKR = 'game\disks\MagicPockets-SKR.adf'
}

$diskPath = Join-Path $projectRoot $diskMap[$Variant]
$winuaePath = @(
    Join-Path $projectRoot 'winuae\winuae64.exe'
    Join-Path $projectRoot 'winuae\winuae.exe'
    Join-Path $projectRoot 'winuae64.exe'
    Join-Path $projectRoot 'winuae.exe'
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $winuaePath) {
    throw "WinUAE executable not found. Place winuae64.exe (or winuae.exe) in the winuae folder."
}

if (-not (Test-Path $configPath)) {
    throw "Missing config file: $configPath"
}

if (-not $romPath) {
    throw "Missing Kickstart ROM. Place kickstart-1.3.rom in the roms folder."
}

if (-not (Test-Path $diskPath)) {
    throw "Missing disk image for variant '$Variant': $diskPath"
}

$launchArgs = @(
    '-f', $configPath
    '-s', "kickstart_rom_file=$romPath"
)

$launchArgs += @('-s', "floppy0=$diskPath")

if ($Windowed) {
    $launchArgs += @('-s', 'gfx_fullscreen_amiga=false')
} else {
    $launchArgs += @('-s', 'gfx_fullscreen_amiga=true')
}

$proc = Start-Process -FilePath $winuaePath -ArgumentList $launchArgs -WorkingDirectory $projectRoot -PassThru -Wait
exit $proc.ExitCode
