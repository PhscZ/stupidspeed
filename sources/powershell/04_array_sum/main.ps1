# task 04 array_sum — expected output: 499999500000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: fill in one loop, read back in a second loop, exactly as specified.

$n = 1000000
$array = New-Object 'int[]' $n

for ([int]$i = 0; $i -lt $n; $i++) {
    $array[$i] = $i
}

[long]$total = 0

for ([int]$i = 0; $i -lt $n; $i++) {
    $total += $array[$i]
}

Write-Output $total
