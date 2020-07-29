
# This is a very simplistic example of what can be done, but a great start if you are just doing your first job processing

# Get start time
$start_time = Get-Date

# Queue up some jobs
for ($i = 0; $i -lt 25; $i++) {
	# Each will run our useless code displaying the time is runs
	Start-Job -Name UselessJob -ScriptBlock {
		$time = Get-Random -Minimum 0 -Maximum 10
		Start-Sleep $time
		Write-Output $time
	}
}

# Loop through and clear the jobs untill there are no jobs left
$total_job_time = 0
$slowest_job = 0
while ((Get-Job -Name UselessJob*).Count -gt 0) {
	foreach ($uselessjob in (Get-Job -Name UselessJob* | Where-Object { $_.State -eq 'Completed' })) {
		$total_job_time += [single]$uselessjob.ChildJobs.output
		if ([single]$uselessjob.ChildJobs.output -gt $slowest_job) { $slowest_job = [single]$uselessjob.ChildJobs.output }
		$uselessjob | Remove-Job
	}
}

# Display the jobs running again, there should be no UselessJobs
Get-Job UselessJob*

# Get end time
$total_actual_time = [int] (New-TimeSpan -Start $start_time -End (Get-Date)).TotalSeconds
$time_saved = [int] $($total_job_time - $total_actual_time)
$time_overhead = [int] $($total_actual_time - $slowest_job)

Write-Host "Done!"
"Time if sequentially done : {0,5} seconds " -f $total_job_time
"Actual time               : {0,5} seconds " -f $total_actual_time
"Time saved                : {0,5} seconds " -f $time_saved

"Slowest job               : {0,5} seconds " -f $slowest_job
"Overhead                  : {0,5} seconds " -f $time_overhead

exit 0
