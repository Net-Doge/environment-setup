#
# Windows PowerShell script for AD DS Deployment
#
Rename-Computer -NewName "ADM-DC" -Force
New-NetIPAddress -InterfaceIndex (Get-NetAdapter | Select-Object -ExpandProperty ifIndex) -IPAddress "10.10.20.9" -PrefixLength 24 -DefaultGateway "10.10.20.1"
Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter | Select-Object -ExpandProperty ifIndex) -ServerAddresses "10.10.20.10"
Import-Module ADDSDeployment
Install-ADDSDomain `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$true `
-Credential (Get-Credential) `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainType "ChildDomain" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NewDomainName "adm" `
-NewDomainNetbiosName "ADM" `
-ParentDomainName "customer.net" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\windows\SYSVOL" `
-Force:$true