
# General

Function divider($text = "-=-", $width = 40, [char] $div_char = "=") {
	[decimal] $div_sides = (($width - $text.length - 2) / 2)

	$div_start = $("$div_char" * ([math]::Floor($div_sides)))
	$div_end = $("$div_char" * [math]::ceiling($div_sides))
	"{0} {1} {2}" -f $div_start, $text, $div_end
}

Try {
	divider "try"

	Write-Output "Do something"
	throw "Oops"
}Catch {
	divider "Catch"
	
	Write-Host "Respond to all errors"
	$error[0].CategoryInfo.Reason
	$error[0].Exception.Source
}


# Catch specific errors
Try {
	divider "try"

	Write-Output "Do something"
	Get-Content c:/path/doesnt/exist.txt  -ErrorAction Stop
}Catch [System.Management.Automation.ItemNotFoundException] {
	divider "Catch"

	Write-Output "Respond to ItemNotFoundException errors"
	# To find the exception class, check $error[0].
	$error[0].CategoryInfo.Reason
	$error[0].Exception.Source
}Catch {
	divider "Catch"

	Write-Host "Respond to all other errors"
}


# Catch errors with finally
Try {
	divider "try"

	Write-Output "Do something"
	Get-Content c:/path/doesnt/exist.txt  -ErrorAction Stop
}Catch [System.Management.Automation.ItemNotFoundException] {
	divider "Catch"

	Write-Output "Respond to ItemNotFoundException errors"
	# To find the exception class, check $error[0].
	$error[0].CategoryInfo.Reason
	$error[0].Exception.Source

	Write-Output "Exiting..."
	exit 1
}Catch {
	divider "Catch"

	Write-Host "Respond to all other errors"
}Finally {
	divider "Finally"

	Write-Output "Regardless do this"
	<#
	You'll be hard pressed to find a use case for this other than 'free allocated resources'
	
	By why is it different than:
	Try { ... }
	catch { ... }
	command ...
	?

	Finally ALWAYS runs and cannnot be interuupted. In the example, I exit in the Catch but the finally still runs
	#>
}

Write-Output "Continue running"

exit 0
