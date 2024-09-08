[CmdletBinding()]
Param()
Process{
    $WebRequest = @{
        Method = 'GET'
        Uri = 'https://officecdn.microsoft.com/pr/wsus/setup.exe'
        OutFile = "$env:temp\odt.exe"
    }
    Invoke-WebRequest @WebRequest

    Start-Process -FilePath WebRequest.OutFile -ArgumentList "/configure ${PSScriptRoot}\OfficeConfig.xml" -Wait -NoNewWindow
}
