[CmdletBinding()]
Param()
Process{
    $Services = @(
        'diagnosticshub.standardcollector.service' # Microsoft (R) Diagnostics Hub Standard Collector Service
        'DiagTrack'                                # Diagnostics Tracking Service
        'dmwappushservice'                         # WAP Push Message Routing Service
        'lfsvc'                                    # Geolocation Service
        'MapsBroker'                               # Downloaded Maps Manager
        'NetTcpPortSharing'                        # Net.Tcp Port Sharing Service
        'RemoteAccess'                             # Routing and Remote Access
        #'RemoteRegistry'                          # Remote Registry
        'SharedAccess'                             # Internet Connection Sharing (ICS)
        'TrkWks'                                   # Distributed Link Tracking Client
        #'WbioSrvc'                                # Windows Biometric Service
        #'WlanSvc'                                 # WLAN AutoConfig
        'WMPNetworkSvc'                            # Windows Media Player Network Sharing Service
        #'wscsvc'                                  # Windows Security Center Service
        #'WSearch'                                 # Windows Search
        'XblAuthManager'                           # Xbox Live Auth Manager
        'XblGameSave'                              # Xbox Live Game Save Service
        'XboxNetApiSvc'                            # Xbox Live Networking Service
        #'ndu'                                     # Windows Network Data Usage Monitor
        'WinHttpAutoProxySvc'                      # WinHTTP Web Proxy Auto-Discovery Service
    )
    ForEach ($Service in $Services) {
        Set-Service -Name $Service -StartupType Disabled
    }

    $TaskPaths = @(
        @{
            Path = '\Microsoft\Windows\Application Experience\'
            Tasks = @(
                'Microsoft Compatibility Appraiser'
                'ProgramDataUpdater'
            )
        },
        @{
            Path = '\Microsoft\Windows\Customer Experience Improvement Program\'
            Tasks = @(
                'Consolidator'
                'KernelCeipTask'
                'UsbCeip'
            )
        }
    )
    ForEach ($TaskPath in $TaskPaths) {
        ForEach ($Task in $TaskPath.Tasks) {
            Disable-ScheduledTask -TaskPath $TaskPath.Path -TaskName $Task
        }
    }
}
