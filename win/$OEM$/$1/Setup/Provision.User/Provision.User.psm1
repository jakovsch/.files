ForEach ($Member in (Get-ChildItem -Path "${PSScriptRoot}\*.ps1")) {
    $Name = [IO.PATH]::GetFileNameWithoutExtension($Member.fullname)
    New-Item -Path "Function:/${Name}" -Value {
        . $Member.fullname
    }
}
