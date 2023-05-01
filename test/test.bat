@echo off

CALL refreshenv
@REM start powershell -noexit -file "%~dp0\test.ps1"
@REM powershell -Command "&{ Start-Process powershell -ArgumentList '-NoExit -File "%~dp0\test.ps1"' -Verb RunAs}"
powershell -ExecutionPolicy Bypass -Command "Start-Process -ErrorAction Stop Powershell -Verb RunAs -Wait -ArgumentList '-NoExit -NoProfile -ExecutionPolicy Bypass -File "%~dp0\test.ps1"'"
pause
