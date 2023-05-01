$ErrorActionPreference = "Stop";

Write-Host $PSScriptRoot
Write-Host "User profile is $env:USERPROFILE"
Write-Host "Program Data is $env:PROGRAMDATA"
Write-Host "SystemDrive is $env:SYSTEMDRIVE"

# Check to make sure script is run as administrator
Write-Host "[+] Checking if script is running as administrator.." -ForegroundColor Green
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-Not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[-] Please run this script as administrator`n" -ForegroundColor Red
    Read-Host  "Press any key to continue"
    exit
}

###############################
# Boxstarter build-in
###############################
Disable-BingSearch

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableItemCheckBox -DisableOpenFileExplorerToQuickAccess -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -DisableExpandToOpenFolder

Read-Host  "Press any key to continue"
