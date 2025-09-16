# Array of user details
$users = @(
    @{Name="Carter"; Surname="A259"; Password="L0vely@Spr!ng33"; DisplayName="Carter-A259"; Username="carter"},
    @{Name="Kat"; Surname="B320"; Password="Qw1ckBreez3@77"; DisplayName="Kat-B320"; Username="kat"},
    @{Name="Jun"; Surname="A266"; Password="Str0ng@Winds99"; DisplayName="Jun-A266"; Username="jun"},
    @{Name="Emile"; Surname="A239"; Password="SunnY@Trail22"; DisplayName="Emile-A239"; Username="emile"},
    @{Name="Jorge"; Surname="052"; Password="CloudyN!ght#88"; DisplayName="Jorge-052"; Username="jorge"},
    @{Name="Noble"; Surname="Six"; Password="5mj!wHWP"; DisplayName="Noble Six"; Username="noblesix"},
    @{Name="John"; Surname="117"; Password="H!ddenV@lley11"; DisplayName="Master Chief (John-117)"; Username="john"},
    @{Name="Cortana"; Surname="AI"; Password="FrosteD@Hill33"; DisplayName="Cortana"; Username="cortanaAI"},
    @{Name="Jacob"; Surname="Keyes"; Password="Cryst@lLake77"; DisplayName="Captain Jacob Keyes"; Username="jacobkeyes"},
    @{Name="Avery"; Surname="Johnson"; Password="StarryN!ght#44"; DisplayName="Sergeant Avery Johnson"; Username="averyjohnson"},
    @{Name="Catherine"; Surname="Halsey"; Password="Comet@Sky123!"; DisplayName="Dr. Catherine Halsey"; Username="catherinehalsey"},
    @{Name="Miranda"; Surname="Keyes"; Password="G@ther1ngW1ld22"; DisplayName="Lieutenant Commander Miranda Keyes"; Username="mirandakeyes"},
    @{Name="Terrence"; Surname="Hood"; Password="SunrisePeak@77"; DisplayName="Lord Terrence Hood"; Username="terrencehood"},
    @{Name="Stanforth"; Surname="Admiral"; Password="C0ldFront#11!"; DisplayName="Fleet Admiral Stanforth"; Username="admiralstanforth"},
    @{Name="Kelly"; Surname="087"; Password="OceanBreez3@44"; DisplayName="Kelly-087"; Username="kelly"},
    @{Name="Fred"; Surname="104"; Password="M!styRiver99@"; DisplayName="Fred-104"; Username="fred"},
    @{Name="Will"; Surname="043"; Password="P@stor@lScene55"; DisplayName="Will-043"; Username="will"},
    @{Name="Romeo"; Surname="087"; Password="W!ntryL@nd88"; DisplayName="Romeo-087"; Username="romeo"},
    @{Name="Delta"; Surname="256"; Password="Moont@lk!ng44"; DisplayName="Delta-256"; Username="delta"},
    @{Name="Sarah"; Surname="Palmer"; Password="Mount@1nF1eld123"; DisplayName="Sarah Palmer"; Username="sarahpalmer"},
    @{Name="Edward"; Surname="Buck"; Password="Skater@Cool12!"; DisplayName="Edward Buck"; Username="edwardbuck"},
    @{Name="Vadum"; Surname=""; Password="P@ssw0rd!@"; DisplayName="Vadum"; Username="vadum"}
)

# Create user accounts in Active Directory
foreach ($user in $users) {
    $username = $user.Username
    $password = $user.Password | ConvertTo-SecureString -AsPlainText -Force
    $displayName = $user.DisplayName

    New-ADUser -Name $displayName -GivenName $user.Name -Surname $user.Surname -SamAccountName $username -UserPrincipalName "$username@unsc.net" -AccountPassword $password -Enabled $true -PasswordNeverExpires $true -DisplayName $displayName
}

Write-Output "All UNSC user accounts have been created in Active Directory."

$users = @("cortanaAI", "mirandakeyes", "admiralstanforth", "jacobkeyes", "john") 
# Loop through each user and add them to the Domain Admins group 
foreach ($user in $users) { 
	Add-ADGroupMember -Identity "Domain Admins" -Members $user 
	Write-Output "Added $user to Domain Admins"
}
