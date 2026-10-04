# task 04 array_sum — expected output: 499999500000
# build: (none; interpreted)    run: powershell -File 04_array_sum.ps1  (PowerShell 7: pwsh -File 04_array_sum.ps1)
# note: fill in one loop, read back in a second loop, exactly as specified.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

$n = 1000000
$array = New-Object 'int[]' $n

for ([int]$i = 0; $i -lt $n; $i++) {
    $array[$i] = $i
}

[long]$total = 0

for ([int]$i = 0; $i -lt $n; $i++) {
    $total += $array[$i]
}

Write-SsTime
Write-Output $total
