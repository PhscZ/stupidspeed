# task 05 alloc_churn — expected output: 1274991808
# build: (none; interpreted)    run: powershell -File 05_alloc_churn.ps1  (PowerShell 7: pwsh -File 05_alloc_churn.ps1)
# note: each 64-byte buffer is a real byte[], 64 bytes and not 64 numbers. Storing it into the
#       256-slot table keeps it reachable and drops the buffer it replaces, so the .NET garbage
#       collector really has ten million dead objects to deal with.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

[long]$total = 0
$slots = New-Object 'byte[][]' 256

for ([long]$i = 0; $i -lt 10000000; $i++) {
    $buf = New-Object byte[] 64
    $buf[0] = [byte]($i -band 255)
    $total += [long]$buf[0]
    $slots[$i % 256] = $buf
}

Write-SsTime
Write-Output $total
