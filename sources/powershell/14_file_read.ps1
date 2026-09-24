# task 14 file_read — expected output: 484442112
# build: (none; interpreted)    run: powershell -File 14_file_read.ps1  (PowerShell 7: pwsh -File 14_file_read.ps1)
# note: data.bin is the 100 MiB fixture (the bytes 0..255 repeating) and is opened by name from the
#       working directory; it is read in 1 MiB chunks, never one byte per syscall. The total is
#       13369344000 before the modulus, which still fits in [long].

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

Write-Output ($total % 4294967296)
