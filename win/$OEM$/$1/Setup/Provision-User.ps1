#Requires -RunAsAdministrator
Start-Transcript -OutputDirectory $PSScriptRoot -IncludeInvocationHeader
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Do {
    $Result = Test-Connection -Count 1 -Quiet -ComputerName '1.1.1.1'
} Until ($Result)

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted

Install-Module -Name NtObjectManager -Force
Install-Module -Name PSWindowsUpdate -Force
#Install-Module -Name Microsoft.WinGet.Client -Force

. $PSScriptRoot\Install-WinGet.ps1
. $PSScriptRoot\Install-WinGetPackages.ps1
. $PSScriptRoot\Install-Office.ps1
. $PSScriptRoot\Set-UserPreferences.ps1
. $PSScriptRoot\Set-PowerProfile.bat

OOSU10.exe $PSScriptRoot\OOSU10.cfg
wsl.exe --install --inbox --no-distribution
#Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot

Set-Culture -CultureInfo hr-HR
Get-ChildItem "$env:USERPROFILE\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }
Get-ChildItem "$env:Public\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }

Disable-ScheduledTask -TaskName '\Provision-User'
Restart-Computer -Force
