# task 15 file_write — expected output: 52428800
# build: (none; interpreted)    run: powershell -File 15_file_write.ps1  (PowerShell 7: pwsh -File 15_file_write.ps1)
# note: a 1 MiB buffer holding the bytes 0..255 repeated 4096 times is written to out.bin 50 times
#       in 1 MiB writes. Flush($true) is .NET's flush-to-disk, so the bytes are on disk before the
#       count is printed, and the stream is then closed.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

$chunk = 1048576
$buffer = New-Object byte[] $chunk

for ([int]$i = 0; $i -lt $chunk; $i++) {
    $buffer[$i] = [byte]($i -band 255)
}

$stream = [System.IO.File]::OpenWrite("out.bin")
[long]$written = 0

for ([int]$n = 0; $n -lt 50; $n++) {
    $stream.Write($buffer, 0, $chunk)
    $written += $chunk
}

$stream.Flush($true)
$stream.Close()

Write-SsTime
Write-Output $written
