Start-Transcript -OutputDirectory $PSScriptRoot -IncludeInvocationHeader
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'HypervisorPlatform'
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Microsoft-Windows-Subsystem-Linux'
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Containers-DisposableClientVM'
Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'WorkFolders-Client'
#Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'MediaPlayback'

. $PSScriptRoot\Disable-ServicesAndTasks.ps1
. $PSScriptRoot\Set-MachinePreferences.ps1

$TaskXML = Get-Content 'C:\Setup\Provision-User.xml' | Out-String
Register-ScheduledTask -Xml $TaskXML -TaskName '\Provision-User' -Force
