:: references:
:: https://ss64.com/nt/syntax-esc.html
:: https://stackoverflow.com/questions/1493979/what-does-the-title-batch-script-command-do
:: https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
:: https://chocolatey.org/docs/installation

@title "Setting Up Your Developement Environment"
@echo off
goto check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        goto package_manager_for_windows
    ) else (
        echo Failure: Current permissions inadequate.
        goto end_setup
    )

:package_manager_for_windows
:: reference below are for installing everything as portable apps
:: https://chocolatey.org/docs/installation#non-administrative-install
:: https://gist.github.com/ferventcoder/78fa6b6f4d6e2b12c89680cbc0daec78
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass ^
-Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072 ^
;iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" ^
&& SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
if %errorLevel% == 0 (
        echo Choco installed. Installing software using choco...
        goto install_dependencies_using_choco
    ) else (
        echo Failure: Choco installation failed. Exiting...
        goto end_setup
    )

:install_dependencies_using_choco
CALL choco install wsl2
CALL choco install wsl-alpine
CALL choco install docker-desktop
CALL choco install vscode

:install_dependencies_absent_from_choco
:: vscode extensions absent from choco
:: https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
CALL code --install-extension --force ms-vscode-remote.vscode-remote-extensionpack
CALL code --install-extension --force ms-vscode.sublime-keybindings
:end_setup
pause

