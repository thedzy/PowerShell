
param(
    $file
)
if ($file) {
    Get-ItemPropertyValue $file -Name CreationTime
}

exit $?