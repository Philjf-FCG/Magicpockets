@echo off
setlocal
set ROOT=%~dp0

set EXE=
set CFG=
set ROMARG=
set FLOPPYARG=

if exist "%ROOT%winuae64.exe" set EXE=%ROOT%winuae64.exe
if not defined EXE if exist "%ROOT%winuae.exe" set EXE=%ROOT%winuae.exe
if not defined EXE if exist "%ROOT%winuae\winuae64.exe" set EXE=%ROOT%winuae\winuae64.exe
if not defined EXE if exist "%ROOT%winuae\winuae.exe" set EXE=%ROOT%winuae\winuae.exe

if exist "%ROOT%magicpockets_steam.uae" set CFG=%ROOT%magicpockets_steam.uae
if not defined CFG if exist "%ROOT%config\MagicPockets.uae" set CFG=%ROOT%config\MagicPockets.uae

if exist "%ROOT%magicpockets_steam.uae" (
    set ROMARG=kickstart-1.3.rom
    set FLOPPYARG=magicpockets-skr.adf
) else (
    set ROMARG=roms/kickstart-1.3.rom
    set FLOPPYARG=game/disks/MagicPockets-SKR.adf
)

if not defined EXE (
    echo WinUAE executable not found.
    echo Expected one of:
    echo   %ROOT%winuae64.exe
    echo   %ROOT%winuae\winuae64.exe
    exit /b 1
)

if not defined CFG (
    echo WinUAE config not found.
    echo Expected one of:
    echo   %ROOT%magicpockets_steam.uae
    echo   %ROOT%config\MagicPockets.uae
    exit /b 1
)

pushd "%ROOT%"
"%EXE%" -f "%CFG%" -s kickstart_rom_file=%ROMARG% -s floppy0=%FLOPPYARG% %*
set ERR=%ERRORLEVEL%
popd
exit /b %ERR%

endlocal