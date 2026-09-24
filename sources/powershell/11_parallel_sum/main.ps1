# task 11 parallel_sum — expected output: 7500000075000000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: four concurrent workers on real .NET threads from a runspace pool, one fixed range each,
#       so the result does not depend on scheduling. Start-Job is not used because it starts a
#       process per job, and ForEach-Object -Parallel does not exist before PowerShell 7.
# note: measured at about 76 s for the four workers together; serial task 02 is about 264 s.

$worker = @'
param([long]$t)
[long]$start = $t * 25000000
[long]$stop = $start + 25000000
[long]$acc = 0
for ([long]$i = $start; $i -lt $stop; $i++) {
    switch ($i % 4) {
        0 { $acc += 1 }
        1 { $acc += $i }
        2 { $acc += 2 * $i }
        3 { $acc += 3 * $i }
    }
}
$acc
'@

$pool = [runspacefactory]::CreateRunspacePool(1, 4)
$pool.Open()

$jobs = @()
for ([int]$t = 0; $t -lt 4; $t++) {
    $shell = [powershell]::Create()
    $shell.RunspacePool = $pool
    [void]$shell.AddScript($worker).AddArgument([long]$t)
    $jobs += [pscustomobject]@{ Shell = $shell; Async = $shell.BeginInvoke() }
}

[long]$total = 0
foreach ($job in $jobs) {
    $result = $job.Shell.EndInvoke($job.Async)
    $total += [long]$result[0]
    $job.Shell.Dispose()
}

$pool.Close()
$pool.Dispose()

Write-Output $total
