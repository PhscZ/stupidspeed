# task 13 matrix_mul — expected output: 599995000
# build: (none; interpreted)    run: powershell -File 13_matrix_mul.ps1  (PowerShell 7: pwsh -File 13_matrix_mul.ps1)
# note: the plain i, j, k triple loop in that order on flat long[] arrays; no library multiply and
#       no loop reordering, so the k-stride is the deliberately unfriendly one.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

$n = 500
$size = $n * $n
$A = New-Object 'long[]' $size
$B = New-Object 'long[]' $size
$C = New-Object 'long[]' $size

for ([int]$i = 0; $i -lt $n; $i++) {
    for ([int]$j = 0; $j -lt $n; $j++) {
        $A[$i * $n + $j] = ($i + $j) % 7
        $B[$i * $n + $j] = ($i * $j) % 5
    }
}

for ([int]$i = 0; $i -lt $n; $i++) {
    [int]$rowA = $i * $n
    for ([int]$j = 0; $j -lt $n; $j++) {
        [long]$sum = 0
        for ([int]$k = 0; $k -lt $n; $k++) {
            $sum += $A[$rowA + $k] * $B[$k * $n + $j]
        }
        $C[$rowA + $j] = $sum
    }
}

[long]$total = 0
for ([int]$idx = 0; $idx -lt $size; $idx++) {
    $total += $C[$idx]
}

Write-SsTime
Write-Output $total
