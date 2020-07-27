$title = "Title"

$answer = [System.Windows.Forms.MessageBox]::Show("Ok dialog.", $title, 0)
Write-Host $answer

$answer = [System.Windows.Forms.MessageBox]::Show("Ok Cancel dialog.", $title, 1)
Write-Host $answer

$answer = [System.Windows.Forms.MessageBox]::Show("Abort Retry Ignore dialog.", $title, 2)
Write-Host $answer

$answer = [System.Windows.Forms.MessageBox]::Show("Yes No Cancel dialog.", $title, 3)
Write-Host $answer
if ($awnser -eq "Yes" ) {
    Write-Host "Yeah!"
} elseif ($answer -eq "No") {
    Write-Host "Neh :("
} else {
    Write-Host "Oh well..."
}

$answer = [System.Windows.Forms.MessageBox]::Show("Yes No dialog.", $title, 4)
Write-Host $answer


while ([System.Windows.Forms.MessageBox]::Show("Retry Cancel dialog.", $title, 5) -eq "Retry") {
    Write-Host "Try again"
}


exit