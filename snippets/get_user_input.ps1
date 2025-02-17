
# Visible input
$username = ( Read-Host "Username" )
# Masked inout
$password = ( Read-Host -AsSecureString "Password" )
Write-Host ("`n{0} : {1}" -f $username , ('*' * $password.length))

# Single key input
Write-Host -NoNewline "Press any key "
$key = ($Host.UI.RawUI.ReadKey())
Write-Host "`nKey : " $key.Character

exit 0