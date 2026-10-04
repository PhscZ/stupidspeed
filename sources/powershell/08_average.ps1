# task 08 average — expected output: 0.498046875
# build: (none; interpreted)    run: powershell -File 08_average.ps1  (PowerShell 7: pwsh -File 08_average.ps1)
# note: [double] throughout; every reading is a multiple of 1/256, so the sum is exact.
#       The 'R' format with the invariant culture prints the plain decimal, no exponent, no commas.
# note: a 100 M-iteration loop costs roughly 264 s under Windows PowerShell 5.1 on this machine.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

[double]$total = 0.0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    [double]$reading = ($i % 256) / 256.0
    $total += $reading
}

[double]$average = $total / 100000000
Write-SsTime
Write-Output $average.ToString('R', [System.Globalization.CultureInfo]::InvariantCulture)
