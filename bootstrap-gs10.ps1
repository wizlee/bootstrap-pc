# Check to make sure script is run as administrator
Write-Host "[+] Checking if script is running as administrator.." -ForegroundColor Green
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-Not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[-] Please run this script as administrator`n" -ForegroundColor Red
    Read-Host  "Press any key to continue"
    exit
}

$ErrorActionPreference = "Stop";

###############################
# Boxstarter build-in
###############################
Disable-BingSearch

# https://boxstarter.org/winconfig
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableItemCheckBox -DisableOpenFileExplorerToQuickAccess -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -DisableExpandToOpenFolder

# https://github.com/chocolatey/boxstarter/blob/develop/Boxstarter.WinConfig/Set-BoxstarterTaskbarOptions.ps1
Set-BoxstarterTaskbarOptions -Size Large -Dock Bottom -Combine Full -AlwaysShowIconsOn -MultiMonitorOn -MultiMonitorMode MainAndOpen -MultiMonitorCombine Full -DisableSearchBox


###############################
# Change power settings
###############################
$powerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'High Performance'"
$powerPlan.Activate()

powercfg /hibernate off
powercfg /change monitor-timeout-ac 0
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0


###############################
# Misc Tweaks Tweaks
# NickCraver gist: https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9
###############################
# Set current network profile to private
Set-NetConnectionProfile -NetworkCategory Private

# Disable Enhance Pointer -> https://www.tenforums.com/tutorials/101691-turn-off-enhance-pointer-precision-windows.html
@('MouseSpeed','MouseThreshold1','MouseThreshold2') |% { Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name $_ -Type DWord -Value 0 }

# Switch windows with a single click! (without clicking on taskbar thumbnail)
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LastActiveClick -Type DWord -Value 1

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-timezone?view=powershell-7.3
Set-TimeZone -Name  "Malay Peninsula Standard Time"

# Import and apply ooshutup10 config
OOSU10.exe $PSScriptRoot/ooshutup10.cfg /quiet

# Disable web search. This seems to be the only way as modification using gpedit or any other registry key don't work
Set-ItemProperty -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Type DWord -Value 1

# Add exclusion path to Windows Defender
Add-MpPreference -ExclusionPath "$env:PROGRAMDATA\chocolatey","$env:SYSTEMDRIVE\source","$env:SYSTEMDRIVE\tools"


# Changing visual effect settings are too tedious, putting reference until found script that others had done this
# https://www.tenforums.com/tutorials/6377-change-visual-effects-settings-windows-10-a.html
# https://superuser.com/questions/1376503/toggle-windows-visual-effects-using-the-command-line


###############################
# Windows 10 Metro App Removals
# This is not needed as Ghost Spectre build removes all of them
# Put this section here as a placeholder for other PC builds
###############################
