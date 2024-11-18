# Array of user details
$users = @(
    @{Name="Carter"; Surname="A259"; Password="password1"; DisplayName="Carter-A259"; Username="carter"},
    @{Name="Kat"; Surname="B320"; Password="password1"; DisplayName="Kat-B320"; Username="kat"},
    @{Name="Jun"; Surname="A266"; Password="password1"; DisplayName="Jun-A266"; Username="jun"},
    @{Name="Emile"; Surname="A239"; Password="password1"; DisplayName="Emile-A239"; Username="emile"},
    @{Name="Jorge"; Surname="052"; Password="password1"; DisplayName="Jorge-052"; Username="jorge"},
    @{Name="Noble"; Surname="Six"; Password="password1"; DisplayName="Noble Six"; Username="noblesix"},
    @{Name="John"; Surname="117"; Password="password1"; DisplayName="Master Chief (John-117)"; Username="john"},
    @{Name="Cortana"; Surname="AI"; Password="password1"; DisplayName="Cortana"; Username="cortanaAI"},
    @{Name="Jacob"; Surname="Keyes"; Password="password1"; DisplayName="Captain Jacob Keyes"; Username="jacobkeyes"},
    @{Name="Avery"; Surname="Johnson"; Password="password1"; DisplayName="Sergeant Avery Johnson"; Username="averyjohnson"},
    @{Name="Catherine"; Surname="Halsey"; Password="password1"; DisplayName="Dr. Catherine Halsey"; Username="catherinehalsey"},
    @{Name="Miranda"; Surname="Keyes"; Password="password1"; DisplayName="Lieutenant Commander Miranda Keyes"; Username="mirandakeyes"},
    @{Name="Terrence"; Surname="Hood"; Password="password1"; DisplayName="Lord Terrence Hood"; Username="terrencehood"},
    @{Name="Stanforth"; Surname="Admiral"; Password="password1"; DisplayName="Fleet Admiral Stanforth"; Username="admiralstanforth"},
    @{Name="Kelly"; Surname="087"; Password="password1"; DisplayName="Kelly-087"; Username="kelly"},
    @{Name="Fred"; Surname="104"; Password="password1"; DisplayName="Fred-104"; Username="fred"},
    @{Name="Will"; Surname="043"; Password="password1"; DisplayName="Will-043"; Username="will"},
    @{Name="Romeo"; Surname="087"; Password="password1"; DisplayName="Romeo-087"; Username="romeo"},
    @{Name="Delta"; Surname="256"; Password="password1"; DisplayName="Delta-256"; Username="delta"},
    @{Name="Sarah"; Surname="Palmer"; Password="password1"; DisplayName="Sarah Palmer"; Username="sarahpalmer"},
    @{Name="Edward"; Surname="Buck"; Password="password1"; DisplayName="Edward Buck"; Username="edwardbuck"},
    @{Name="Vadum"; Surname=""; Password="password1"; DisplayName="Vadum"; Username="vadum"}
)

# Create user accounts in Active Directory
foreach ($user in $users) {
    $username = $user.Username
    $password = $user.Password | ConvertTo-SecureString -AsPlainText -Force
    $displayName = $user.DisplayName

    New-ADUser -Name $displayName -GivenName $user.Name -Surname $user.Surname -SamAccountName $username -UserPrincipalName "$username@unsc.net" `
        -AccountPassword $password -Enabled $true -PasswordNeverExpires $true -Path "OU=Users,DC=unsc,DC=net" -DisplayName $displayName
}

Write-Output "All UNSC user accounts have been created in Active Directory."

$users = @("cortanaAI", "mirandakeyes", "admiralstanforth", "jacobkeyes", "john") 
# Loop through each user and add them to the Domain Admins group 
foreach ($user in $users) { 
	Add-ADGroupMember -Identity "Domain Admins" -Members $user 
	Write-Output "Added $user to Domain Admins"
}
