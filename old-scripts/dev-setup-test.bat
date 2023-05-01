:: references:
:: https://www.robvanderwoude.com/escapechars.php
:: https://ss64.com/nt/syntax-esc.html
:: https://stackoverflow.com/questions/1493979/what-does-the-title-batch-script-command-do
:: https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
:: https://chocolatey.org/docs/installation

@title "Setting Up Your Developement Environment"
@echo off
GOTO check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        echo.
        echo.
        GOTO package_manager_for_windows
    ) else (
        echo Failure: Current permissions inadequate.
        echo.
        GOTO end_setup
    )

:package_manager_for_windows
:: https://stackoverflow.com/questions/6037146/how-to-execute-powershell-commands-from-a-batch-file
:: reference below are for installing everything as portable apps
:: https://chocolatey.org/docs/installation#non-administrative-install
:: https://gist.github.com/ferventcoder/78fa6b6f4d6e2b12c89680cbc0daec78
echo --------------------------------
echo Installing choco...
echo --------------------------------
CALL powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
if %errorLevel% == 0 (
        echo Choco installed. Installing software using choco...
        echo.
        echo.
        GOTO choose_env_setup_type
    ) else (
        echo Failure: Choco installation failed. Exiting...
        echo.
        GOTO end_setup
    )

:: ----------------------------------------------
:: Choose which environment to setup
:: ----------------------------------------------
:: https://stackoverflow.com/a/42723345/2809828
:choose_env_setup_type
choice /C 123 /M "Select Mode (1 :- General Software Developement; 2 :- ATE & SET; 3 :- Abort Setup): "
GOTO option-%errorlevel%

:option-1
echo.
echo --------------------------------
echo General Software Developement
echo --------------------------------
GOTO install_dependencies_for_general_dev

:option-2
echo.
echo --------------------------------
echo Setting up environment for ATE ^& SET
echo --------------------------------
GOTO installation_for_ATE_and_SET

:option-3
echo Aborting setup...
GOTO end_setup


:: ----------------------------------------------
:: General
:: ----------------------------------------------
:install_dependencies_for_general_dev
echo install dependencies using choco...
CALL choco install wsl2
CALL choco install wsl-ubuntu-2004 REM absent in home dev setup
CALL choco install docker-desktop
CALL choco install vscode
CALL choco install vscode-cpptools
CALL choco install mobaxterm REM absent in home dev setup
echo.
echo install dependencies absent from choco...
:: 1. vscode extensions absent from choco
:: https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
CALL code --install-extension --force ms-vscode-remote.vscode-remote-extensionpack
CALL 
echo.
GOTO end_setup

:: ----------------------------------------------
:: ATE & SET
:: ----------------------------------------------
:installation_for_ATE_and_SET
echo install dependencies using choco...
CALL choco install vscode-python
CALL choco install mysql.workbench REM absent in home dev setup
CALL choco install rdmfree REM absent in home dev setup
echo.
echo install dependencies absent from choco...
:: 1. vscode extensions absent from choco
:: https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
echo.
GOTO install_dependencies_for_general_dev

:end_setup
pause

