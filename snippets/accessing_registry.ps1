

# We will need admin access for this
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$admin_status = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ( -not  $admin_status ) {
    Write-Host "Signing into admin"
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($MyInvocation.MyCommand.Definition))
    exit $LASTEXITCODE
}

# Works virtually identical to file system acess
# Get a path and list the children
Get-Item -Path HKLM:\SOFTWARE | Get-ChildItem | ForEach-Object { Write-Output $_.Name }

# Create a new child
New-Item -Path HKLM:\SOFTWARE -Name "thedzy" -Value "default value" -Force
# Create a key
New-ItemProperty -Path HKLM:\SOFTWARE\thedzy -Name "website"-PropertyType String -Value "thedzy.com"

$currect_pwd = $PWD
# Change root path and get properties with a relative path
Set-Location -Path hklm:\SOFTWARE\thedzy
Get-Item -Path . | Select-Object -ExpandProperty Property
Get-ItemProperty -Path .

# Return back to our original location
Set-Location -Path $currect_pwd

# Remove the entry
Remove-ItemProperty -Path HKLM:\SOFTWARE\thedzy -Name "website"
# Remove the key
Remove-Item  -Path HKLM:\SOFTWARE\thedzy