@echo off

echo Finished installing packages using choco. Using boxstarter to automate everything else.
echo .
echo 1. Ghost Spectre 10
echo 2. Vanila Windows 11
choice /c 12 /n /m "Enter 1/2 to run your desired setup:"
set setup=%errorlevel%

echo start another process to make sure setup variable still contains the outout of choice
call calc
echo end

if %setup% == 1 goto setup_ghost_spectre_10
if %setup% == 2 goto setup_vanila_win11

:setup_ghost_spectre_10
CALL refreshenv
goto end_setup

:setup_vanila_win11
@REM start powershell -noexit -file "%~dp0\test.ps1"
@REM powershell -Command "&{ Start-Process powershell -ArgumentList '-NoExit -File "%~dp0\test.ps1"' -Verb RunAs}"
powershell -ExecutionPolicy Bypass -Command "Start-Process -ErrorAction Stop Powershell -Verb RunAs -Wait -ArgumentList '-NoExit -NoProfile -ExecutionPolicy Bypass -File "%~dp0\test.ps1"'"
goto end_setup

:end_setup
pause
