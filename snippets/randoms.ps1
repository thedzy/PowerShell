
#############################
# RANDOMS letter and numbers
#############################

# DIGITS, 0-2147483647
Get-Random

# DIGITS, 0-9
Write-Output (Get-Random -Maximum 9)

# BASE64, 48 alphanumeric characters
$base64 = [char[]](0..255) -clike '[A-Za-z0-9+/]'
Write-Output ( -join (1..48 | ForEach-Object { ($base64 | Get-Random) }))

# Hex, 16 characters
Write-Output ( -join (0..16 | ForEach-Object { "{0:X}" -f (Get-Random -Max 15) }))

# 12 alphanumeric characters
$alphanum = [char[]](0..255) -clike '[A-Za-z0-9]'
Write-Output ( -join (1..12 | ForEach-Object { ($alphanum | Get-Random) }))

# 12 alphabetic characters
$alphabet = [char[]](0..255) -clike '[A-Za-z]'
Write-Output ( -join (1..12 | ForEach-Object { ($alphabet | Get-Random) }))

# DIGITS, 0-99999999 (8 digits formatted)
Write-Output ( -join (0..8 | ForEach-Object { (Get-Random -Max 9) }))

# Random choice
"One", "Two", "Three" | Get-Random

#############################
# RANDOMS files
#############################

# Make a 1mb file in the temp
New-Item -Path $env:TEMP -Name "1mbfile" -ItemType "file" -Force -Value ( -join (0..1024 | ForEach-Object { [char](Get-Random -Max 127) }))

# Make a 1mb file in the desktop with zeros
New-Item -Path $env:TEMP -Name "1mbfile" -ItemType "file" -Force -Value ( -join (0..1024 | ForEach-Object { [char]0 }))



