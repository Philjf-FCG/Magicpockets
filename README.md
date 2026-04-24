# Magic Pockets - WinUAE Steam Project

This project is aligned to the same WinUAE Steam packaging style used in Barbarian.

## Included game data

The provided archive was unpacked into normalized ADF files:

- game/disks/MagicPockets.adf (CSL crack, no trainer)
- game/disks/MagicPockets-Plus4.adf (CSL +4 trainer)
- game/disks/MagicPockets-SKR.adf (SKR crack)

## Local dependencies

1. WinUAE portable files in winuae/
   - Required: winuae64.exe
2. Kickstart ROM in roms/
   - Required: kickstart-1.3.rom

These can be copied from the Barbarian project at:

- ../Barbarbaraian/Content/ThirdParty/Amiga/WinUAE/winuae64.exe
- ../Barbarbaraian/Content/ThirdParty/Amiga/kickstart-1.3.rom

## Launch locally

From this folder:

```powershell
.\Launch-MagicPockets.ps1
```

Variant options:

```powershell
.\Launch-MagicPockets.ps1 -Variant CSL
.\Launch-MagicPockets.ps1 -Variant CSLTrainer
.\Launch-MagicPockets.ps1 -Variant SKR
```

Windowed mode:

```powershell
.\Launch-MagicPockets.ps1 -Windowed
```

## Build Steam package folder

```powershell
.\Build-SteamPackage.ps1
```

Output is created at:

- dist/Steam-WinUAE

## Steam setup

1. Add dist/Steam-WinUAE as your Steam build content root.
2. Preferred executable: winuae64.exe
3. Preferred launch options: -f magicpockets_steam.uae
4. Optional alternate disk launch options:
   - -s floppy0=magicpockets-plus4.adf
   - -s floppy0=magicpockets-skr.adf
5. Alternative executable: Launch-MagicPockets.bat

## Notes

- The generated package includes the same core file pattern as Barbarian's Steam-WinUAE artifacts.
