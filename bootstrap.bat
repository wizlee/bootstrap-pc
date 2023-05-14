@title "Setting Up Your PC"
@echo off
goto check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        echo .
        echo 1. Ghost Spectre 10
        echo 2. Vanila Windows 11
        choice /c 12 /n /m "Enter 1/2 to run your desired setup:"
        set setup=%errorlevel%
        goto package_manager_for_windows
    ) else (
        echo Failure: Current permissions inadequate.
        goto end_setup
    )

:package_manager_for_windows
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass ^
-Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072 ^
;iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" ^
&& SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
if %errorLevel% == 0 (
  echo Choco installed. Installing software using choco...
  goto install_packages_using_choco
) else (
  echo Failure: Choco installation failed. Exiting...
  goto end_setup
)

:install_packages_using_choco
CALL choco install shutup10 -y
CALL choco install keepass -y
CALL choco install keepass-plugin-keeanywhere -y
CALL choco install keepass-plugin-keetheme -y
CALL choco install joplin -y
CALL choco install slickrun -y
CALL choco install choco-cleaner -y
CALL choco install vscode -y
CALL choco install git -y
CALL choco install bleachbit -y
CALL choco install geekuninstaller -y
CALL choco install miniconda3 -y
CALL choco install 7zip -y
CALL choco install spacesniffer -y
CALL choco install sysinternals -y
CALL choco install nirlauncher --params="'/Sysinternals'" -y
CALL choco install boxstarter -y
refreshenv

echo Finished installing packages using choco. Using boxstarter to automate everything else.
if %setup% == 1 goto setup_ghost_spectre_10
if %setup% == 2 goto setup_vanila_win11


:setup_ghost_spectre_10
@REM https://stackoverflow.com/questions/75632275/call-a-powershell-script-with-elevated-privileges-via-command-prompt?noredirect=1&lq=1
powershell -ExecutionPolicy Bypass -Command "Start-Process Powershell -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "%~dp0\bootstrap-gs10.ps1"'"
if %errorLevel% == 0 (
  echo Successfully setup PC. Exiting...
  goto end_setup
) else (
  echo Failure: Boxstarter setup returned %errorLevel%. Exiting...
  goto end_setup
)

:setup_vanila_win11
powershell -ExecutionPolicy Bypass -Command "Start-Process Powershell -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "%~dp0\bootstrap-win11.ps1"'"
if %errorLevel% == 0 (
  echo Successfully setup PC. Exiting...
  goto end_setup
) else (
  echo Failure: Boxstarter setup returned %errorLevel%. Exiting...
  goto end_setup
)

:end_setup
pause
