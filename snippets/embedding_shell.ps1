
# Check for python first

wsl --list | out-null
if ($?){
	Write-Host "Linux installations Found"
} else {
   write-host "No linux subsystems are isntalled"
   exit 1
}

Write-Host "Do some PowerShell stuff"

$msg = "Hello, this is %s in PowerShell\n"

Write-Host $("-" * 40)


# Insert PowerShell variables using formatting
[string] $code = '
MSG="{0}"
LANGUAGE="{1}"

printf "$MSG" $LANGUAGE

' -f $msg, "Bash"
$code -replace "`r", "`n"  | wsl --exec

Write-Host $("-" * 40)


# Embedding bash vaiables into bash code
@"
printf `"$msg`" Bash

"@ -replace "`r", "`n"  | wsl --exec


Write-Host $("-" * 40)


# Keeping bash code as pure literal
$code = @'
printf "We are running $BASH_VERSION\n"
'@
$code | wsl --exec

Write-Host $("-" * 40)


# Captuing the output of bash
$platform = (@'
printf "$BASH_VERSION\n"
'@ | wsl --exec) | Out-String
write-host "We are running $platform"

Write-Host $("-" * 40)


Write-Host "Back to PowerShell stuff"

exit 0
