# task 06 char_count — expected output: 10000000
# build: (none; interpreted)    run: powershell -File 06_char_count.ps1  (PowerShell 7: pwsh -File 06_char_count.ps1)
# note: the 100 MB string is built in one operation ("abcdefghij" * 10000000), never by appending.
# note: scanning 100 M characters one at a time is slow even for PowerShell. That is a
#       result, not a bug.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

$text = "abcdefghij" * 10000000
[long]$count = 0

for ([int]$i = 0; $i -lt $text.Length; $i++) {
    $ch = $text[$i]
    if ($ch -eq [char]'a') {
        # skip
    }
    elseif ($ch -eq [char]'e') {
        # skip
    }
    elseif ($ch -eq [char]'h') {
        $count++
    }
    else {
        # skip
    }
}

Write-SsTime
Write-Output $count
