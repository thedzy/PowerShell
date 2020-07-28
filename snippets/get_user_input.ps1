
# Visible input
$username = ( Read-Host "Username" )
# Masked inout
$password = ( Read-Host -asSecureString "Password" )
write-host "`n$username : ********"

# Single key input
write-host -NoNewLine "Press any key "
$key = ($Host.UI.RawUI.ReadKey())
Write-Host "`nKey : " $key.Character

exit 0