
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
	# Positional argument
	[Parameter(Position = 0)][string] $path,
	# A single character
	[Parameter(Position = 1)][char] $char = 'a',

	# An integer of 1-100
	[Parameter(Position = 2)][ValidateRange(0, 50)][int] $integer = 50,

	# Action, pull or push
	[Parameter(Mandatory, Position = 3, HelpMessage="Push or Pull")][ValidateSet('Push', 'Pull')][string] $action,
	# Username
	[Parameter(Position = 4)][Alias('user')][string] $username = $( Read-Host "Username" ),
	# Password
	[Parameter(Position = 5)][Alias('pass')][string] $password = $( Read-Host -asSecureString "NOT an actual password" )
)

# Additional feild validation, (other than data types, done by "param")
write-host $path
if (!( Test-Path $path)) {
	Write-Host "Posional parameter 1 must be a valid path"
	exit
}

##########################################################################################
# Main
################

write-host 
write-host '$char      :' $char

write-host '$integer   :' $integer

write-host 'Action     :' $action
write-host 'Username   :' $username
write-host 'Password   : *********'

write-host 'Position 1 : ' $path

exit