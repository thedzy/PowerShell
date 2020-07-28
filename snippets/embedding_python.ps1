
# Check for python first
$python = "python.exe"
if (Get-Command $python -ErrorAction SilentlyContinue){
	Write-Host "Found $python at " $(Get-Command $python).Source
} else {
   write-host "$python is not isntalled or not in the system PATH"
   exit 1
}

Write-Host "Do some PowerShell stuff"

$msg = "Hello, this is {} in PowerShell"

Write-Host $("-" * 40)


# Insert PowerShell variables using formatting
[string] $code = "
msg = '{0}'
language = '{1}'

print(msg.format(language))
" -f $msg, "Python"
$code | & $python

Write-Host $("-" * 40)


# Embedding PowerShell vaiables into python code
@"
print('$msg'.format('Python'))
"@ | & $python


Write-Host $("-" * 40)


# Keeping python code as pure literal
$code = @'
import platform

system = platform.platform().lower()
print("We are running {}".format(system))
'@
$code | & $python

Write-Host $("-" * 40)


# Captuing the output of Python
$platform = (@'
import platform

print(platform.platform().lower())
'@ | & $python) | Out-String
write-host "We are running $platform"

Write-Host $("-" * 40)


Write-Host "Back to PowerShell stuff"

exit 0
