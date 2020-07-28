
# Parse arguments/parameters (Only the ones specified on the next line)

<#
	.SYNOPSIS
		A simple positional parameter script.

	.DESCRIPTION
        ... blah blah blah, longer version of the SYNOPSIS....
    
    .EXAMPLE
        arguments_positional_alt.ps1 test1 test2 ...
#>

if ($args.Count -eq 0) {
    Write-Host "Run with arguments"
} else {
    $counter = 0
    foreach ($arg in $args) {
        $counter++
        Write-Host "Argument $counter :" $arg
    }
}

exit