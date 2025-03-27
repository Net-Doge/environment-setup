# This is a post-deployment script that requires ADDS already installed

# Create OUs for domain
New-ADOrganizationalUnit -Name "Domain Users" -Path "DC=customer,DC=net"

# Usernames and Domain Administrators
$customerUsers = @("ethan.roberts1993", "zoey.thompson1988", "ryan.baker1981", "hannah.perez1990", "caleb.morris1984", "violet.rodriguez1992", "nicholas.paterson1980", "layla.wood1985", "johnson.jackson1987", "aurora.morgan1983", "owen.reed1978", "lucy.ross1977", "joshua.perry1982", "stella.cox1989", "levi.richards1991", "aiden.hughes1986", "lily.gray1979", "andrew.butler1993", "victoria.bennett1988", "charlotte.rivera1990")
$customerDomainAdmins = @("admin.customer1", "admin.customer2", "admin.customer3", "admin.customer4", "admin.customer5")

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
Create-ADUsers -users $customerUsers -domain "customer.net" -path "OU=Domain Users,DC=customer,DC=net"
Create-DomainAdmins -admins $customerDomainAdmins -domain "customer.net" -path "OU=Domain Users,DC=customer,DC=net" -group "Domain Admins"

# Start NTP Server
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer" /v Enabled /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config" /v AnnounceFlags /t REG_DWORD /d 5 /f
net stop w32time
net start w32time
echo "NTP Server Key: $((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer" -Name Enabled).Enabled)"
echo "Announce Flags: $((Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Config" -Name AnnounceFlags).AnnounceFlags)"
