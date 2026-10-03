# task 07 string_append — expected output: 250000
# build: (none; interpreted)    run: powershell -File 07_string_append.ps1  (PowerShell 7: pwsh -File 07_string_append.ps1)
# note: .NET strings are immutable, so plain $text += "x" copies the whole string every iteration.
#       That quadratic behaviour is the point of the task, so no growable buffer is substituted.

$text = ""

for ([int]$i = 0; $i -lt 250000; $i++) {
    $text += "x"
}

Write-Output $text.Length
