
# Get the current user
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
# Check the current role of the user
$admin_status = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

# If not and admin, elevate
if ( -not  $admin_status ) {
    Write-Host "Signing into admin"
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($MyInvocation.MyCommand.Definition))
    exit $LASTEXITCODE
}

Write-Host "Do stuff"

exit