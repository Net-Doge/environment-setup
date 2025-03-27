# This is a post-deployment script that requires ADDS already installed
# Create OUs for domain
New-ADOrganizationalUnit -Name "Domain Users" -Path "DC=fin,DC=customer,DC=net"

# Usernames and Domain Administrators
$finCustomerUsers = @("alex.wilson1990", "ella.king1987", "william.scott1979", "harper.green1984", "daniel.phillips1982", "scarlett.carter1991", "matthew.cook1985", "chloe.mitchell1980", "henry.bailey1986", "nora.evans1983", "jack.hill1977", "ella.turner1989", "logan.walker1976", "grace.allen1992", "samuel.collins1988")
$finDomainAdmins = @("admin.fin1", "admin.fin2", "admin.fin3", "admin.fin4", "admin.fin5")

# Password Pool
$passwords = @("L0vely@Spr!ng33", "Qw1ckBreez3@77", "Str0ng@Winds99", "SunnY@Trail22", "CloudyN!ght#88", "H!ddenV@lley11", "FrosteD@Hill33", "Cryst@lLake77", "StarryN!ght#44", "Comet@Sky123!", "G@ther1ngW1ld22", "SunrisePeak@77", "C0ldFront#11!", "OceanBreez3@44", "M!styRiver99@", "P@stor@lScene55", "W!ntryL@nd88", "Moont@lk!ng44", "Mount@1nF1eld123", "Skater@Cool12!", "Br!ghtH!lls88!", "For3st@Run33", "Cheer@fulMorn44", "WinterH@ven123", "LakePl@cid999!", "T!dal@Wave123", "Blizz@rdZone77", "Sunsh!neDay33!", "Flow3ryPeak99@", "Peaceful@Dawn88", "Silver@Forest44", "StarryMorn!ng22", "Brisk@Hikes999", "Magic@Summit99", "GoldenPeak!77", "Quiet@Woods444", "GentleBr33z3!", "IceCryst@l123", "WarmT1dal@Wave", "Meadow@Rays22", "ShinyMoonl!ght", "RainyD@wn1122", "Cheerful@Night", "SunsetV@lley99", "Tropic@Island44", "OceanTr@il333", "Casc@dingFalls", "Spr!ngtimeJoy@", "MoonlitP@ths88", "Lucky@Star333", "PowerT@ldes222", "GentleF0rest99", "Calm@Fields12!", "Thunder@Hill99", "CrystalN!ght22", "DancingSt@rs888", "FrostyP@sture1", "Fresh@Mountain", "SunsetT!me123", "PeacefulSky@55", "C!trusPeak1234", "QuietValley@88", "B@lmyDawn1234", "EarlyR!ser@22", "DreamyW@ves999", "StarryN1ght!88", "IceyPeak@1122", "Ch@rmingLake33", "SunlitP@ths444", "Quiet@Ocean111", "Serene@Forest22", "LivelyH!kes12!", "M!ldH@ze333333", "IceB@rnTime88", "StormyDawn4444", "Peaceful@Rain88", "SunnyHorizon@1", "CheerfulM!ghty", "Crystal@Lake99", "HiddenF0rt33!", "ColdNight@Sky1", "FoggyF@rest22", "R1singSky@8888", "Chill@Haven55", "Ser@eneHike999", "DawnPeak@Light", "MornSkyTr@cker", "For3stWay@Hill", "ScenicStar@4!", "WarmFlow@22", "B0ltingHill77@!", "Trop!calStar44", "LuckyStorm@888", "StormSky12@@@", "CozyHaven1234", "ShinyMorning@11", "SunlitForest@1", "ScenicTrail!11", "WarmDaybreak!1", "MidnightM@gic")

# Helper function for creating users
function Create-ADUsers {
    param ([array]$users, [string]$domain, [string]$path)
    foreach ($user in $users) {
        $password = $passwords | Get-Random
        New-ADUser -SamAccountName $user -Name $user -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $path
        Write-Host "Created user: $user in $domain with password: $password"
    }
}

# Helper function for creating domain administrators
function Create-DomainAdmins {
    param ([array]$admins, [string]$domain, [string]$path, [string]$group)
    foreach ($admin in $admins) {
        $password = $passwords | Get-Random
        New-ADUser -SamAccountName $admin -Name $admin -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $path
        Add-ADGroupMember -Identity $group -Members $admin
        Write-Host "Created domain admin: $admin in $domain with password: $password"
    }
}

# Create regular users and domain administrators
Create-ADUsers -users $finCustomerUsers -domain "fin.customer.net" -path "OU=Domain Users,DC=fin,DC=customer,DC=net"
Create-DomainAdmins -admins $finDomainAdmins -domain "fin.customer.net" -path "OU=Domain Users,DC=fin,DC=customer,DC=net" -group "Domain Admins"

#Set ntp host:
$NTPHost = "10.10.20.10"
w32tm /config /manualpeerlist:"$NTPHost,0x8" /syncfromflags:manual /update
net stop w32time
net start w32time
w32tm /resync /force
w32tm /query /status