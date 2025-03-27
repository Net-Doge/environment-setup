#
# Windows PowerShell script for AD DS Deployment
#
New-NetIPAddress -InterfaceIndex (Get-NetAdapter | Select-Object -ExpandProperty ifIndex) -IPAddress "10.10.20.10" -PrefixLength 24 -DefaultGateway "10.10.20.1"
Rename-Computer -NewName "CUS-DC01" -Force
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "customer.net" `
-DomainNetbiosName "CUSTOMER" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\windows\SYSVOL" `
-Force:$true
