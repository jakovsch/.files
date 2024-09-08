Import-Module .\Provision.Machine
Start-Transcript -OutputDirectory $PSScriptRoot -IncludeInvocationHeader
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Set-OptionalFeatures
Set-MachinePreferences
Disable-ServicesAndTasks

$TaskXML = Get-Content "${PSScriptRoot}\Provision-User.xml" | Out-String
Register-ScheduledTask -Xml $TaskXML -TaskName '\Provision-User' -Force
