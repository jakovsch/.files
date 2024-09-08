#Requires -RunAsAdministrator
Import-Module .\Provision.User
Start-Transcript -OutputDirectory $PSScriptRoot -IncludeInvocationHeader
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Set-PowerProfile
Set-UserPreferences
Set-DesktopAndLocale

While (Get-NetConnectionProfile | Where-Object {
    $_.IPv4Connectivity -eq 'Internet' -or $_.IPv6Connectivity -eq 'Internet'
} -ne $null) {
    Write-Warning "Provision: Waiting for network"
    Start-Sleep 5
}

#Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
Install-PSModules
Install-WinGet
Install-Programs
Install-Office
Install-WSL
Set-ExternalTools

Disable-ScheduledTask -TaskName '\Provision-User'
Restart-Computer -Force
