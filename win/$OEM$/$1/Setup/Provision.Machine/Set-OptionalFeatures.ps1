[CmdletBinding()]
Param()
Process{
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'MediaPlayback'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'HypervisorPlatform'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Microsoft-Windows-Subsystem-Linux'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Containers-DisposableClientVM'

    Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'WorkFolders-Client'
}
