
# Parse arguments/parameters (Only the ones specified on the next line)

<#
	.SYNOPSIS
		A simple positional parameter script.

	.DESCRIPTION
		... blah blah blah, longer version of the SYNOPSIS....
#>


# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-attributes?view=powershell-7
# Alias with Alais(name)

# Validate with 
# ValidateCount(min, max)
# ValidateLength(min, max)
# ValidatePattern(regex)
# ValidateRange(min, max)
# ValidateSet([value1, value2, ...])

# Comment before each parameter becomes help if not specified in the block abover
param (
	# A single character
	[char] $char = 'a',
	# A string of 1-10 characters
	[ValidateLength(1, 10)][string] $string = 'abc',

	# An integer of 1-100
	[ValidateRange(0, 50)][int] $integer = 100,
	# A decimal number
	[decimal] $decimal = 0.00,

	# A valid date
	[DateTime] $date,

	# Valid xml data
	[xml] $xml = "<xml></xml>",
	# Array of 1-3 items
	[ValidateCount(1, 3)][array] $array = (1, 2, 3),

	# True or False
	[bool] $bool = $true,
	# True if specified
	[switch] $help = $false,

	# Action, pull or push
	[Parameter(Mandatory, HelpMessage = "Push or Pull")][ValidateSet('Push', 'Pull')][string] $action,
	# Username
	[Alias('user')][string] $username = $( Read-Host "Username" ),
	# Password
	[Alias('pass')][string] $password = $( Read-Host -AsSecureString "NOT an actual password" ),


	# Positional argument
	[Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string] $path
)

# Additional feild validation, (other than data types, done by "param")
if (!( Test-Path $path)) {
	Write-Host "Posional parameter 1 must be a valid path"
	exit
}

##########################################################################################
# Help
################

if ($help) {
	Get-Help $PSCommandPath
	exit
}

##########################################################################################
# Main
################

Write-Host 
Write-Host '$char      :' $char
Write-Host '$string    :' $string

Write-Host '$bool      :' $bool

Write-Host '$integer   :' $integer
Write-Host '$decimal   :' $decimal

Write-Host '$date      :' $date

Write-Host '$xml       :' $xml
Write-Host '$array     :' $array

Write-Host 'Action     :' $action
Write-Host 'Username   :' $username
Write-Host 'Password   : *********'

Write-Host 'Position 1 : ' $path

exit

