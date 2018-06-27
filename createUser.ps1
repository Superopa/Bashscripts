if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$OU_Path = "OU=Beheer,OU=Afdelingen,DC=Ypey,DC=LOCAL"


$group = "Beheer"
$pw = read-host "Password" -AsSecureString


Import-CSV C:\Users\Evander\Desktop\users.csv | foreach {
$user = $_.SamAccountName 


New-ADUser  `
-Name $_.Name `
-SamAccountName $user `
-GivenName $_.GivenName `
-Surname $_.Surname `
-DisplayName $_.DisplayName `
-UserPrincipalName $_.UserPrincipalName `
-AccountPassword $pw `
-ChangePasswordAtLogon $false `
-Enabled $true `
-Path $OU_Path
Add-ADGroupMember $group $user }