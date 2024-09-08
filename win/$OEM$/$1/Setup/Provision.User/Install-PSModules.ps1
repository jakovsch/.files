[CmdletBinding()]
Param()
Process{
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository PSGallery -InstallationPolicy Trusted

    Install-Module -Name NtObjectManager -Force
    Install-Module -Name PSWindowsUpdate -Force
    Install-Module -Name PolicyFileEditor -Force
    #Install-Module -Name Microsoft.WinGet.Client -Force
}
