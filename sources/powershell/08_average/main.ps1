# task 08 average — expected output: 0.498046875
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: [double] throughout; every reading is a multiple of 1/256, so the sum is exact.
#       The 'R' format with the invariant culture prints the plain decimal, no exponent, no commas.
# note: a 100 M-iteration loop costs roughly 264 s under Windows PowerShell 5.1 on this machine and
#       may hit the 300 s benchmark timeout. That is a documented result, not a bug.

[double]$total = 0.0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    [double]$reading = ($i % 256) / 256.0
    $total += $reading
}

[double]$average = $total / 100000000
Write-Output $average.ToString('R', [System.Globalization.CultureInfo]::InvariantCulture)
