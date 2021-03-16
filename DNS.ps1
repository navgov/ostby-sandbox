Install-WindowsFeature DNS -IncludeManagementTools
Add-DnsServerForwarder -IPAddress 168.63.129.16 -PassThru
Add-DnsServerConditionalForwarderZone -Name "nav.no" -MasterServers 8.8.8.8,8.8.4.4 -PassThru
