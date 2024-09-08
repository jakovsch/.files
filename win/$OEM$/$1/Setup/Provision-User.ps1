#Requires -RunAsAdministrator
Import-Module .\Provision.User
Start-Transcript -OutputDirectory $PSScriptRoot -IncludeInvocationHeader
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Do {
    $Result = Test-Connection -Count 1 -Quiet -ComputerName '1.1.1.1'
} Until ($Result)

Install-PSModules
Install-WinGet
Install-WinGetPackages
Install-Office
Set-UserPreferences
Set-PowerProfile

OOSU10.exe $PSScriptRoot\OOSU10.cfg
wsl.exe --install --inbox --no-distribution
#Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot

Set-Culture -CultureInfo hr-HR
Get-ChildItem "$env:USERPROFILE\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }
Get-ChildItem "$env:Public\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }

Disable-ScheduledTask -TaskName '\Provision-User'
Restart-Computer -Force
