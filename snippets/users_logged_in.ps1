

$lusers = (Get-CimInstance Win32_LoggedOnUser -ComputerName $ComputerName).antecedent.name | Select-Object -Unique

echo "Logged in users: " $lusers

exit