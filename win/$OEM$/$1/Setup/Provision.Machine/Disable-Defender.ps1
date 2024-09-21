[CmdletBinding()]
Param()
Process{
    $RegPaths = @(
        @{
            Item = 'HKLM:\Software\Microsoft\Windows Defender\Features'
            Properties = @(
                @{
                    Name = 'TamperProtection'
                    Type = 'DWord'
                    Value = '4'
                },
                @{
                    Name = 'TamperProtectionSource'
                    Type = 'DWord'
                    Value = '2'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows Defender'
            Properties = @(
                @{
                    Name = 'DisableAntiSpyware'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'ServiceKeepAlive'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows Defender\Real-Time Protection'
            Properties = @(
                @{
                    Name = 'DisableBehaviorMonitoring'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'DisableRealtimeMonitoring'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        }
    )
    ForEach ($RegPath in $RegPaths) {
        If (!(Test-Path $RegPath.Item)) {
            New-Item -Path $RegPath.Item -Force
        }
        ForEach ($Property in $RegPath.Properties) {
            New-ItemProperty -Force -Path $RegPath.Item @Property
        }
    }
}
