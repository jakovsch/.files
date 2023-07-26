[CmdletBinding()]
Param()
Process{
    $InvokeWebRequestSplat = @{
        Method = 'GET'
        Uri = 'https://officecdn.microsoft.com/pr/wsus/setup.exe'
        OutFile = "$env:temp\odt.exe"
    }
    Invoke-WebRequest @InvokeWebRequestSplat

    Start-Process -FilePath InvokeWebRequestSplat.OutFile -ArgumentList "/configure $PSScriptRoot\OfficeConfig.xml" -Wait -NoNewWindow
}
