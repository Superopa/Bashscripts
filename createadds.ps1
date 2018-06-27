get-windowsfeature
New-NetIPAddress –InterfaceAlias “Ethernet0” –IPAddress 192.168.242.128 –PrefixLength 24 -DefaultGateway 192.168.242.2
import-module servermanager
Install-windowsfeature AD-domain-services -IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest `
 -CreateDnsDelegation:$false `
 -DatabasePath "C:\Windows\NTDS" `
 -DomainMode "7" `
 -DomainName "ypey.local" `
 -DomainNetbiosName "YPEY" `
 -ForestMode "7" `
 -InstallDns:$true `
 -LogPath "C:\Windows\NTDS" `
 -NoRebootOnCompletion:$false `
 -SysvolPath "C:\Windows\SYSVOL" `
 -Force:$true