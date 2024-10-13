[CmdletBinding()]
Param()
Process{
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'MediaPlayback'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'HypervisorPlatform'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Microsoft-Windows-Subsystem-Linux'
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'Containers-DisposableClientVM'
    #Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
    #Add-WindowsCapability -Online -Name 'Media.MediaFeaturePack~~~~0.0.1.0'

    Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'WorkFolders-Client'
    Remove-WindowsCapability -Online -Name 'MathRecognizer~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Print.Fax.Scan~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'App.StepsRecorder~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'App.Support.QuickAssist~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Media.WindowsMediaPlayer~~~~0.0.12.0'
    Remove-WindowsCapability -Online -Name 'Hello.Face.18967~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Hello.Face.Migration.18967~~~~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Language.OCR~~~en-US~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Language.Speech~~~en-US~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Language.TextToSpeech~~~en-US~0.0.1.0'
    Remove-WindowsCapability -Online -Name 'Language.Handwriting~~~en-US~0.0.1.0'
}
