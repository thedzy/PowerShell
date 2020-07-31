
$log_file = "$env:TEMP/loffile.log"
Clear-Content $log_file

Write-Output "Start Stricpt with no redirection"

# Redirect a block
&{
    Write-Output "Redirect a block"
}  > $log_file

# Redirect all outputS
$ErrorActionPreference = "Continue"
Start-Transcript -path $log_file -append

Write-Output "Do something"

Stop-Transcript

Write-Output "File contents:"
Get-Content $log_file