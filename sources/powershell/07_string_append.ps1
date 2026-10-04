# task 07 string_append — expected output: 250000
# build: (none; interpreted)    run: powershell -File 07_string_append.ps1  (PowerShell 7: pwsh -File 07_string_append.ps1)
# note: .NET strings are immutable, so plain $text += "x" copies the whole string every iteration.
#       That quadratic behaviour is the point of the task, so no growable buffer is substituted.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

$text = ""

for ([int]$i = 0; $i -lt 250000; $i++) {
    $text += "x"
}

Write-SsTime
Write-Output $text.Length
