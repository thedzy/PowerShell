#!/bin/bash

# To see what is going on behind the scenes, uncomment the next line
#Set-PSDebug -Trace 2

# Simple recusrive Loop, breaking with an "if"
# Not practical example
Function Loop($int) {
	if ($int -ge 10) { return $int } else {
		$int++
		return Loop $int
	}
}
Write-Output $(Loop 0) 

Function Find-Key ($key, $dataset) {
	if ($dataset.Contains($key)) {
		return $dataset[$key]
	} else {
		foreach ($subkey in $dataset.Keys) {
			if ($dataset[$subkey] -is [System.Collections.Hashtable]) {
				Find-Key $key -dataset $dataset[$subkey]
			}
		}
	}

}

$dataset = @{
	"US"     = @{
		"NY"    = @{
			"Susan" = 10;
			"James" = 40
		};
		"CA"    = @{
			"Lilly"      = 42;
			"John"       = 32;
			"Sacramento" = @{
				"Billy" = 9;
				"Sandy" = 3
			}
		};
		"Jerry" = 1
	}
	"Canada" = @{
		"Alex"  = 25;
		"Sarah" = 15
	};
	"Linda"  = 78;
}

$key = "Billy"
Write-Output "$key : $(Find-key $key -dataset $dataset)"

Set-PSDebug -Off


