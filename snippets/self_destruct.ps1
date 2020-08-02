
# Self destructing script

# Get file info
$file = ([System.IO.DirectoryInfo] $MyInvocation.InvocationName)
$file_path = Split-Path -Path $file -Parent
$file_leaf = Split-Path -Path $file -Leaf
$file_ext = $file.Extension  
$file_base = (Split-Path -Path $file -Leaf).Replace($file_ext, "")
$file_new = Join-Path $file_path "$file_base.$(Get-Date -Format "yyyy.MM.dd.HH.mm.ss")$file_ext"

# Because this is a demo, let's create a copy first
Copy-Item -Path $file.FullName -Destination $file_new

# Delete file before the contents have run
Remove-Item -Path $file.FullName -Force

# Create some output, because the script is loaded into memory, it will still complete
Write-Output "File Extension: $file_ext"
Write-Output "File Name:      $file_leaf"
Write-Output "File Path:      $file_path"

Write-Output DONE

exit 0