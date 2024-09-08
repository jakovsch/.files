[CmdletBinding()]
Param()
Process{
    Function Install-WinGetPackage($ID) {
        $winget = "$((Get-AppxPackage Microsoft.DesktopAppInstaller).InstallLocation)\winget.exe"
        . $winget install --accept-package-agreements --accept-source-agreements --silent --exact --id $ID
    }

    $Packages = @(
        'Microsoft.VCRedist.2015+.x64'
        'Microsoft.VCRedist.2013.x64'
        'Microsoft.VCRedist.2012.x64'
        'Microsoft.VCRedist.2010.x64'
        'Microsoft.VCRedist.2008.x64'
        'Microsoft.VCRedist.2005.x64'
        'Microsoft.WindowsTerminal'
        'Microsoft.OfficeDeploymentTool'
        'OO-Software.ShutUp10'
        'REALiX.HWiNFO'
        'WinFsp.WinFsp'
        '7zip.7zip'
        'CodeSector.TeraCopy'
        'AntibodySoftware.WizTree'
        'BleachBit.BleachBit'
        'nomacs.nomacs'
        'VideoLAN.VLC'
        'eloston.ungoogled-chromium'
    )
    ForEach ($Package in $Packages) {
        Install-WinGetPackage $Package
    }
}
