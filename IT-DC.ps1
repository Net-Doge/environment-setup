# Create the Organizational Unit for IT.net
New-ADOrganizationalUnit -Name "Domain Users" -Path "DC=it,DC=net"

# Regular Users for IT.net with Roles
$itUsers = @(
    @{FirstName="Mark"; LastName="Johnson"; Role="HelpDesk"},
    @{FirstName="Emma"; LastName="Smith"; Role="HelpDesk"},
    @{FirstName="David"; LastName="Brown"; Role="NetworkAdmin"},
    @{FirstName="Olivia"; LastName="Williams"; Role="NetworkAdmin"},
    @{FirstName="Chris"; LastName="Jones"; Role="SysAdmin"},
    @{FirstName="Sophia"; LastName="Taylor"; Role="SysAdmin"},
    @{FirstName="James"; LastName="Moore"; Role="DevOps"},
    @{FirstName="Michael"; LastName="Clark"; Role="DevOps"},
    @{FirstName="Noah"; LastName="King"; Role="SecurityAdmin"},
    @{FirstName="Ava"; LastName="Walker"; Role="SecurityAdmin"},
    @{FirstName="Elijah"; LastName="White"; Role="DatabaseAdmin"},
    @{FirstName="Charlotte"; LastName="Hill"; Role="DatabaseAdmin"},
    @{FirstName="Lucas"; LastName="Scott"; Role="BackupAdmin"},
    @{FirstName="Mia"; LastName="Green"; Role="BackupAdmin"},
    @{FirstName="Henry"; LastName="Lee"; Role="CloudAdmin"}
)

# Domain Administrators for IT.net
$itDomainAdmins = @(
    @{FirstName="Admin1"; LastName="IT"},
    @{FirstName="Admin2"; LastName="IT"},
    @{FirstName="Admin3"; LastName="IT"},
    @{FirstName="Admin4"; LastName="IT"},
    @{FirstName="Admin5"; LastName="IT"}
)

# Unified Password Pool
$passwords = @(
    "L0vely@Spr!ng33", "Qw1ckBreez3@77", "Str0ng@Winds99", "SunnY@Trail22", "CloudyN!ght#88",
    "H!ddenV@lley11", "FrosteD@Hill33", "Cryst@lLake77", "StarryN!ght#44", "Comet@Sky123!"
)

# Create Role Groups
$roles = @("HelpDesk", "NetworkAdmin", "SysAdmin", "DevOps", "SecurityAdmin", "DatabaseAdmin", "BackupAdmin", "CloudAdmin")
foreach ($role in $roles) {
    if (-not (Get-ADGroup -Filter "Name -eq '$role'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $role -GroupScope Global -GroupCategory Security -Path "OU=Domain Users,DC=it,DC=net"
        Write-Host "Created group: $role"
    }
}

# Helper function for creating users
function Create-ADUsers {
    param ([array]$users, [string]$path, [string]$domain)
    foreach ($user in $users) {
        $password = $passwords | Get-Random
        $samAccountName = ($user.FirstName.Substring(0,1) + $user.LastName).ToLower()
        New-ADUser -SamAccountName $samAccountName -Name "$($user.FirstName) $($user.LastName)" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $path
        Add-ADGroupMember -Identity $user.Role -Members $samAccountName
        Write-Host "Created user: $($user.FirstName) $($user.LastName) in $domain with role: $($user.Role) and SamAccountName: $samAccountName"
    }
}

# Helper function for creating domain administrators
function Create-DomainAdmins {
    param ([array]$admins, [string]$path, [string]$domain, [string]$group)
    foreach ($admin in $admins) {
        $password = $passwords | Get-Random
        $samAccountName = ($admin.FirstName.Substring(0,1) + $admin.LastName).ToLower()
        New-ADUser -SamAccountName $samAccountName -Name "$($admin.FirstName) $($admin.LastName)" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $path
        Add-ADGroupMember -Identity $group -Members $samAccountName
        Write-Host "Created domain admin: $($admin.FirstName) $($admin.LastName) in $domain with SamAccountName: $samAccountName"
    }
}

# Create regular users and domain administrators for IT.net
Create-ADUsers -users $itUsers -path "OU=Domain Users,DC=it,DC=net" -domain "it.net"
Create-DomainAdmins -admins $itDomainAdmins -path "OU=Domain Users,DC=it,DC=net" -domain "it.net" -group "Domain Admins"
