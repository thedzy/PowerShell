
# Verbose will out put to screen as well as log
param(
    [switch][alias("verbose")] $global:verbose = $false
)

# This will abort the script if in verbose
$ErrorActionPreference = "stop"
trap [System.Exception] {
	# Display error but supress system message
    Write-Error $_
    continue
}

# Define our log file so that our overrides don't need an additional parameter
Set-Variable -Name log_file -Value "$env:TEMP/log_file.log" -Scope Global -Force

# Overriddes for the write commands.
function Write-Host ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "MESSAGE"
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Host ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}
function Write-Debug ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "DEBUG"
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Debug ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}
function Write-Error ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "ERROR"
    $args
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Error ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}
function Write-Information ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "INFO"
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Information ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}
function Write-Verbose ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "VERBOSE"
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Verbose ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}
function Write-Warning ($text) {
    $timestamp = Get-Date -Format FileDateTimeUniversal
    $type = "WARNING"
    if ($global:verbose) { Microsoft.PowerShell.Utility\Write-Warning ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) @args }
    ("{0} [{1,-10}] {2}" -f $timestamp, $type, $text) | Add-Content $Global:log_file
}

# Do some stuff....
Clear-Content $Global:log_file
Write-Host "Starting"


Write-Information "Do something"
Write-Host "Opening a file"
Get-Content c:/path/doesnt/exist.txt -ErrorAction Stop

Write-Host "Thwowing a custom error"
throw "Oh No! mY own error!"

Write-Output "----- Contents of log -----"
Get-Content $log_file


exit 
