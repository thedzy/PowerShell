

param ($ip = "1.0.0.0")

Function divider($text = "-=-", $width = 40, [char] $div_char = "=") {
	[decimal] $div_sides = (($width - $text.length - 2) / 2)

	$div_start = $("$div_char" * ([math]::Floor($div_sides)))
	$div_end = $("$div_char" * [math]::ceiling($div_sides))
	"{0} {1} {2}" -f $div_start, $text, $div_end
}

Write-Output "Validating $ip"

divider "Regex"
divider "Test 1"
# Not great, quick and dirty, but 300.300.300.300/8 will validate
if ( $ip -match '^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/?[0-9]{0,2}$' ) {
	Write-Output YES
} else {
	Write-Output NO
}


divider "Test 2"
# Better, but 299.299.299.299/8 will validate and it doesn't recognise 2 characters
if ( $ip -match '^[0-2][0-9][0-9]\.[0-2][0-9][0-9]\.[0-2][0-9][0-9]\.[0-2][0-9][0-9]/?[0-9]{0,2}$' ) {
	Write-Output YES
} else {
	Write-Output NO
}


divider "Test 3"
# Better, we will validat 0**, 1** or 24* or 25(-6)
if ( $ip -match '^([1-9]|[0-9][0-9]|0[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[0-9][0-9]|0[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[0-9][0-9]|0[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[0-9][0-9]|0[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])/?[0-9]{0,2}$' ) {
	Write-Output YES
} else {
	Write-Output NO
}


divider "Test 4"
# Better, we repeat the 2nd and 3 octet and remove some redundant values
if ( $ip -match '^([1-9]|[0-9][0-9]|0[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.((0?[0-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){2}(0?[0-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\/?[0-9]{0,2}$
' ) {
	Write-Output YES
} else {
	Write-Output NO
}

divider "Test 5"
# Better, if we don't care that valid ips cannot start with zero and we are looking by pattern only (as indicated my a CIDR thus far, which we clearn up here)
if ( $ip -match '^(([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])(?(?=\/)\/[0-9]{1,2})$' ) {
	Write-Output YES
} else {
	Write-Output NO
}

divider "Test 6"
# We can still improve the cider check at this point as it is limited to 0 -99, so we will do that here
if ( $ip -match '^(([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])(?(?=\/)\/([0-9]|[0-2][0-9]|3[0-2]))$' ) {
	Write-Output YES
} else {
	Write-Output NO
}


divider "Spliting and validating"
divider "Test 7"
$valid_octals
$ip_components = $ip.split('/')
[int[]]$ip_array = $ip_components[0].split('.')

foreach ($octal in $ip_array) {
	if ([int] $octal -ge 0 -and [int] $octal -le 255) { $valid_octals++ }
}

if ($ip_components[1]) {
	if ([int] $ip_components[1] -ge 0 -and [int] $ip_components[1] -le 32) {
		$valid_cidr = $true
	} else {
		$valid_cidr = $false
	}
} else {
	$valid_cidr = $true
}

if ($valid_octals -eq 4 -and $valid_cidr) {
	Write-Output YES
} else {
	Write-Output NO
}


divider "Type Casting"
divider "Test 8"
# We still need to check the cidr seperatly.
try {
	[System.Net.IPAddress] $ip_components[0] | Out-Null

	if ($ip_components[1]) {
		if ([int] $ip_components[1] -ge 0 -and [int] $ip_components[1] -le 32) {
			Write-Output YES
		} else {
			Write-Output NO
		}
	} else {
		Write-Output YES
	}
} catch {
	Write-Output NO
}


divider "Test 9"
try {
	[System.Net.IPAddress]::Parse($ip_components[0]) | Out-Null

	if ($ip_components[1]) {
		if ([int] $ip_components[1] -ge 0 -and [int] $ip_components[1] -le 32) {
			Write-Output YES
		} else {
			Write-Output NO
		}
	} else {
		Write-Output YES
	}
} catch {
	Write-Output NO
}

exit