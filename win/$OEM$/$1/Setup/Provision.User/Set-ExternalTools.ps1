[CmdletBinding()]
Param()
Process{
    OOSU10 "${PSScriptRoot}\OOSU10.cfg"
    wsl --set-default-version 2
}
