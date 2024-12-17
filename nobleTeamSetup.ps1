# Array of user details
$users = @(
    @{Name="Carter"; Surname="A259"; Password="P@ssw0rd!@"; DisplayName="Carter-A259"; Username="carter"},
    @{Name="Kat"; Surname="B320"; Password="P@ssw0rd!@"; DisplayName="Kat-B320"; Username="kat"},
    @{Name="Jun"; Surname="A266"; Password="P@ssw0rd!@"; DisplayName="Jun-A266"; Username="jun"},
    @{Name="Emile"; Surname="A239"; Password="P@ssw0rd!@"; DisplayName="Emile-A239"; Username="emile"},
    @{Name="Jorge"; Surname="052"; Password="P@ssw0rd!@"; DisplayName="Jorge-052"; Username="jorge"},
    @{Name="Noble"; Surname="Six"; Password="P@ssw0rd!@"; DisplayName="Noble Six"; Username="six"}
)

# Create user accounts in Active Directory
foreach ($user in $users) {
    $username = $user.Username
    $password = $user.Password | ConvertTo-SecureString -AsPlainText -Force
    $displayName = $user.DisplayName

    New-ADUser -Name $displayName -GivenName $user.Name -Surname $user.Surname -SamAccountName $username -UserPrincipalName "$username@unsc.net" -AccountPassword $password -Enabled $true -PasswordNeverExpires $true -DisplayName $displayName
    Write-Output "Created $user account"
    Add-ADGroupMember -Identity "Domain Admins" -Members $user 
    Write-Output "Added $user to Domain Admins"
}

Write-Output "Noble Team has been Created"
