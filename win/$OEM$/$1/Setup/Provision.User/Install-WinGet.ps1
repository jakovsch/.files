[CmdletBinding()]
Param()
Process{
    Import-Module NtObjectManager

    $AppxDependencies = @(
        @{
            ShortName     = 'xaml'
            QualifiedName = 'Microsoft.UI.Xaml.2.7_8wekyb3d8bbwe'
        },
        @{
            ShortName     = 'vclibs'
            QualifiedName = 'Microsoft.VCLibs.140.00_8wekyb3d8bbwe'
        },
        @{
            ShortName     = 'vclibsuwp'
            QualifiedName = 'Microsoft.VCLibs.140.00.UWPDesktop_8wekyb3d8bbwe'
        }
    )
    ForEach ($Dependency in $AppxDependencies) {
        $WebRequest = @{
            Uri             = 'https://store.rg-adguard.net/api/GetFiles'
            Method          = 'POST'
            ContentType     = 'application/x-www-form-urlencoded'
            Body            = "type=PackageFamilyName&url=$($Dependency.QualifiedName)&ring=Retail&lang=en-US"
            UseBasicParsing = $True
        }
        $WebRequest = @{
            Uri     = ((Invoke-WebRequest @WebRequest).Links | Where-Object {$_.OuterHTML -match '.appx' -and $_.outerHTML -match 'x64'}).href
            OutFile = "$env:temp\$($Dependency.ShortName).appx"
        }
        Invoke-WebRequest @WebRequest
    }

    $RestMethod = @{
        Uri    = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'
        Method = 'GET'
    }
    $LatestRelease = Invoke-RestMethod @RestMethod
    $WebRequest = @{
        Uri     = ($LatestRelease.assets | Where-Object {$_.name -like '*.msixbundle'}).browser_download_url
        OutFile = "$env:temp\winget.msixbundle"
    }
    Invoke-WebRequest @WebRequest
    $WebRequest = @{
        Uri     = ($LatestRelease.assets | Where-Object {$_.name -like '*license*.xml'}).browser_download_url
        OutFile = "$env:temp\wingetlicense.xml"
    }
    Invoke-WebRequest @WebRequest

    $AppxDependencies.ShortName | ForEach-Object {
        $AppxPackage = @{
            Online = $True
            SkipLicense = $True
            PackagePath = "$env:temp\$($_).appx"
        }
        Add-AppxProvisionedPackage @AppxPackage
    }
    $AppxPackage = @{
        Online = $True
        PackagePath = "$env:temp\winget.msixbundle"
        LicensePath = "$env:temp\wingetlicense.xml"
    }
    Add-AppxProvisionedPackage @AppxPackage
    Add-AppxPackage -DisableDevelopmentMode -Register "$((Get-AppxPackage Microsoft.DesktopAppInstaller).InstallLocation)\AppxManifest.xml"

    $ExecutionAlias = @{
        Path        = "$([System.Environment]::SystemDirectory)\winget.exe"
        PackageName = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe'
        EntryPoint  = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe!winget'
        Target      = "$((Get-AppxPackage Microsoft.DesktopAppInstaller).InstallLocation)\winget.exe"
        AppType     = 'Desktop'
        Version     = 3
    }
    Set-ExecutionAlias @ExecutionAlias
    & explorer.exe "shell:appsFolder\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe!winget"
}
