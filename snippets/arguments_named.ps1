
# Parse arguments/parameters (Only the ones specified on the next line)

<#
	.SYNOPSIS
		A simple positional parameter script.

	.DESCRIPTION
		... blah blah blah, longer version of the SYNOPSIS....

	.PARAMETER char
		A single character
	.PARAMETER string
		A string of 1-10 characters
	.PARAMETER integer
		An integer of 1-100
	.PARAMETER decimal
		A decimal number
	.PARAMETER date
		A valid date
	.PARAMETER xml
		Valid xml data
	.PARAMETER array
		Array of 1-3 items
	.PARAMETER bool
		True or False
	.PARAMETER help
		True if specified
	.PARAMETER action
		Action, pull or push
	.PARAMETER username
		Username
	.PARAMETER password
		Password
#>

# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-attributes?view=powershell-7
# Alias with Alais(name)

# Validate with 
# ValidateCount(min, max)
# ValidateLength(min, max)
# ValidatePattern(regex)
# ValidateRange(min, max)
# ValidateSet([value1, value2, ...])

param (
	[char] $char = 'a',
	[ValidateLength(1, 10)][string] $string = 'abc',

	# Get a number
	# Use can also use single, double, or byte
	[ValidateRange(0, 50)][int] $integer = 100,
	[decimal] $decimal = 0.00,

	# Get a date
	[DateTime] $date,

	# Get structured data
	[xml] $xml = "<xml></xml>",
	[ValidateCount(1, 3)][array] $array = (1, 2, 3),

	# Booleans
	# Switch will automatically set value by its presence and does not take a value
	[bool] $bool = $true,
	[switch] $help = $false,

	# Require fileds and data validation
	[Parameter(Mandatory, HelpMessage = "Push or Pull")][ValidateSet('Push', 'Pull')][string] $action,
	# Prompt for the username, same as using "Mandatory", alias parameter
	[Alias('user')][string] $username = $( Read-Host "Username" ),
	# Prompt for the password securely, alias parameter
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