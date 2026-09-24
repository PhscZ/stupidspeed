# task 12 matrix_add — expected output: 999000000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: flat long[] arrays indexed by i * n + j, which is what the task prefers.

$n = 1000
$size = $n * $n
$A = New-Object 'long[]' $size
$B = New-Object 'long[]' $size
$C = New-Object 'long[]' $size

for ([int]$i = 0; $i -lt $n; $i++) {
    for ([int]$j = 0; $j -lt $n; $j++) {
        $A[$i * $n + $j] = $i + $j
        $B[$i * $n + $j] = $i - $j
    }
}

for ([int]$idx = 0; $idx -lt $size; $idx++) {
    $C[$idx] = $A[$idx] + $B[$idx]
}

[long]$total = 0
for ([int]$idx = 0; $idx -lt $size; $idx++) {
    $total += $C[$idx]
}

Write-Output $total
