[CmdletBinding()]
Param()
Process{
    $RegPaths = @(
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'
            Properties = @(
                @{
                    Name = 'EnableAutoTray'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'ShowFrequent'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ShowRecent'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
            Properties = @(
                @{
                    Name = 'Hidden'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'HideFileExt'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'HideDrivesWithNoMedia'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'LaunchTo'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'ShowSuperHidden'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ShowSecondsInSystemClock'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'ShowCortanaButton'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ShowTaskViewButton'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ShowSyncProviderNotifications'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ShowStatusBar'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'TaskbarAnimations'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'TaskbarGlomLevel'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'TaskbarSmallIcons'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'Start_TrackProgs'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'Start_TrackDocs'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'DisableThumbnailCache'
                    Type = 'DWord'
                    Value = '1'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\HideDesktopIcons\NewStartPanel'
            Properties = @(
                @{
                    Name = '{20D04FE0-3AEA-1069-A2D8-08002B30309D}'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = '{59031a47-3f72-44a7-89c5-5595fe6b30ee}'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
            Properties = @(
                @{
                    Name = 'SystemUsesLightTheme'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'AppsUseLightTheme'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'EnableTransparency'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'ColorPrevalence'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search'
            Properties = @(
                @{
                    Name = 'SearchboxTaskbarMode'
                    Type = 'DWord'
                    Value = '2'
                },
                @{
                    Name = 'BingSearchEnabled'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
            Properties = @(
                @{
                    Name = 'ContentDeliveryAllowed'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'FeatureManagementEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'OemPreInstalledAppsEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'PreInstalledAppsEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'PreInstalledAppsEverEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SilentInstalledAppsEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SubscribedContentEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SystemPaneSuggestionsEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'RotatingLockScreenEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'RotatingLockScreenOverlayEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SlideshowEnabled'
                    Type = 'DWord'
                    Value = '0'
                },
                @{
                    Name = 'SoftLandingEnabled'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\DWM'
            Properties = @(
                @{
                    Name = 'ColorPrevalence'
                    Type = 'DWord'
                    Value = '1'
                },
                @{
                    Name = 'EnableAeroPeek'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Control Panel\Desktop'
            Properties = @(
                @{
                    Name = 'MenuShowDelay'
                    Type = 'String'
                    Value = '10'
                }
            )
        },
        @{
            Item = 'HKCU:\Control Panel\Accessibility\StickyKeys'
            Properties = @(
                @{
                    Name = 'Flags'
                    Type = 'String'
                    Value = '506'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost'
            Properties = @(
                @{
                    Name = 'EnableWebContentEvaluation'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
            Properties = @(
                @{
                    Name = 'Enabled'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        },
        @{
            Item = 'HKCU:\Software\Microsoft\Siuf\Rules'
            Properties = @(
                @{
                    Name = 'NumberOfSIUFInPeriod'
                    Type = 'DWord'
                    Value = '0'
                }
            )
        }
    )
    ForEach ($RegPath in $RegPaths) {
        ForEach ($Property in $RegPath.Properties) {
            If (!(Test-Path $RegPath.Item)) {
                New-Item -Path $RegPath.Item -Force
            }
            New-ItemProperty -Force -Path $RegPath.Item @Property
        }
    }
}
