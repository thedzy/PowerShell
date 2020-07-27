
# Parse stdin
# echo stdin | arguments_stdin.ps1

<#
	.SYNOPSIS
		A simple stdin parameter script.

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
	# STDIN argument
	[Parameter(ValueFromPipeline)][string] $stdin
)


##########################################################################################
# Main
################

write-host 
write-host '$stdin' $stdin      
exit