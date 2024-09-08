[CmdletBinding()]
Param()
Process{
    $RegPaths = @(
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection'
            Properties = @(
                @{
                    Name = 'AllowTelemetry'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'DoNotShowFeedbackNotifications'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi'
            Properties = @(
                @{
                    Name = 'AllowWiFiHotSpotReporting'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'AllowAutoConnectToWiFiSenseHotspots'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer'
            Properties = @(
                @{
                    Name = 'SmartScreenEnabled'
                    Type = 'String'
                    Value = 'Off'
                },
                @{
                    Name = 'DisableAppInstallsOnFirstLogon'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}'
            Properties = @(
                @{
                    Name = 'SensorPermissionState'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
            Properties = @(
                @{
                    Name = 'ConsentPromptBehaviorAdmin'
                    Type = 'DWord'
                    Value = '5'
                },
                @{
                    Name = 'ConsentPromptBehaviorUser'
                    Type = 'DWord'
                    Value = '3'
                },
                @{
                    Name = 'PromptOnSecureDesktop'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'VerboseStatus'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'EnableFirstLogonAnimation'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
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
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet'
            Properties = @(
                @{
                    Name = 'SpyNetReporting'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SubmitSamplesConsent'
                    Type = 'DWord'
                    Value = '2'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
            Properties = @(
                @{
                    Name = 'AllowCortana'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'AllowSearchToUseLocation'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ConnectedSearchUseWeb'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'DisableWebSearch'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\OOBE'
            Properties = @(
                @{
                    Name = 'DisablePrivacyExperience'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Error Reporting'
            Properties = @(
                @{
                    Name = 'Disabled'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\TabletPC'
            Properties = @(
                @{
                    Name = 'PreventHandwritingDataSharing'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\HandwritingErrorReports'
            Properties = @(
                @{
                    Name = 'PreventHandwritingErrorReports'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\GameDVR'
            Properties = @(
                @{
                    Name = 'AllowGameDVR'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\OneDrive'
            Properties = @(
                @{
                    Name = 'DisableFileSyncNGSC'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\HotspotAuthentication'
            Properties = @(
                @{
                    Name = 'Enabled'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\DeliveryOptimization'
            Properties = @(
                @{
                    Name = 'DODownloadMode'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\AppCompat'
            Properties = @(
                @{
                    Name = 'DisableInventory'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'AITEnable'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\System'
            Properties = @(
                @{
                    Name = 'AllowClipboardHistory'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'AllowCrossDeviceClipboard'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'EnableActivityFeed'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'EnableSmartScreen'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'PublishUserActivities'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'UploadUserActivities'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\LocationAndSensors'
            Properties = @(
                @{
                    Name = 'DisableLocation'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'DisableLocationScripting'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'DisableSensors'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'DisableWindowsLocationProvider'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent'
            Properties = @(
                @{
                    Name = 'DisableSoftLanding'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'DisableWindowsConsumerFeatures'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU'
            Properties = @(
                @{
                    Name = 'NoAutoUpdate'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'AUOptions'
                    Type = 'DWord'
                    Value = '2'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\WindowsStore'
            Properties = @(
                @{
                    Name = 'AutoDownload'
                    Type = 'DWord'
                    Value = '2'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\InputPersonalization'
            Properties = @(
                @{
                    Name = 'AllowInputPersonalization'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'RestrictImplicitTextCollection'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'RestrictImplicitInkCollection'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\SQMClient\Windows'
            Properties = @(
                @{
                    Name = 'CEIPEnable'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows Search'
            Properties = @(
                @{
                    Name = 'DisableAutomaticRemovableDriveIndexing'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection'
            Properties = @(
                @{
                    Name = 'AllowTelemetry'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'MaxTelemetryAllowed'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp'
            Properties = @(
                @{
                    Name = 'DisableWpad'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient'
            Properties = @(
                @{
                    Name = 'EnableMulticast'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\Software\Policies\Microsoft\Windows NT\SystemRestore'
            Properties = @(
                @{
                    Name = 'DisableSR'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\System\CurrentControlSet\Control\Remote Assistance'
            Properties = @(
                @{
                    Name = 'fAllowFullControl'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'fAllowToGetHelp'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKLM:\System\CurrentControlSet\Services\NlaSvc\Parameters\Internet'
            Properties = @(
                @{
                    Name = 'EnableActiveProbing'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKLM:\System\CurrentControlSet\Services\NetBT\Parameters\Interfaces\tcpip*'
            Properties = @(
                @{
                    Name = 'NetbiosOptions'
                    Type = 'DWord'
                    Value = '2'
                }
            )
        },
        @{
            Item = 'HKLM:\System\CurrentControlSet\Services\Dnscache\Parameters'
            Properties = @(
                @{
                    Name = 'EnableMDNS'
                    Type = 'DWord'
                    Value = '0'
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

    (Get-WmiObject -List Win32_NetworkAdapterConfiguration).EnableWINS($false, $false)
    (Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IpEnabled="true").SetTcpipNetbios(2)
    Get-NetAdapterBinding -ComponentID "ms_tcpip6" | Disable-NetAdapterBinding -ComponentID "ms_tcpip6"
}
