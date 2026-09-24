# task 15 file_write — expected output: 104857600
# build: (none; interpreted)    run: powershell -File 15_file_write.ps1  (PowerShell 7: pwsh -File 15_file_write.ps1)
# note: a 1 MiB buffer holding the bytes 0..255 repeated 4096 times is written to out.bin 100 times
#       in 1 MiB writes. Flush($true) is .NET's flush-to-disk, so the bytes are on disk before the
#       count is printed, and the stream is then closed.

$chunk = 1048576
$buffer = New-Object byte[] $chunk

for ([int]$i = 0; $i -lt $chunk; $i++) {
    $buffer[$i] = [byte]($i -band 255)
}

$stream = [System.IO.File]::OpenWrite("out.bin")
[long]$written = 0

for ([int]$n = 0; $n -lt 100; $n++) {
    $stream.Write($buffer, 0, $chunk)
    $written += $chunk
}

$stream.Flush($true)
$stream.Close()

Write-Output $written
