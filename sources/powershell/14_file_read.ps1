# task 14 file_read — expected output: 2389704704
# build: (none; interpreted)    run: powershell -File 14_file_read.ps1  (PowerShell 7: pwsh -File 14_file_read.ps1)
# note: data.bin is the 50 MiB fixture (the bytes 0..255 repeating) and is opened by name from the
#       working directory; it is read in 1 MiB chunks, never one byte per syscall. The total is
#       6684672000 before the modulus, which still fits in [long].
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
$stream = [System.IO.File]::OpenRead("data.bin")
$buffer = New-Object byte[] $chunk
[long]$total = 0

while ($true) {
    $read = $stream.Read($buffer, 0, $chunk)
    if ($read -le 0) {
        break
    }
    for ([int]$i = 0; $i -lt $read; $i++) {
        $total += [long]$buffer[$i]
    }
}

$stream.Close()

Write-SsTime
Write-Output ($total % 4294967296)
