[CmdletBinding()]
Param()
Process{
    Set-Culture -CultureInfo hr-HR
    Get-ChildItem "$env:USERPROFILE\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }
    Get-ChildItem "$env:Public\Desktop\*.lnk" | ForEach-Object { Remove-Item $_ }
}
