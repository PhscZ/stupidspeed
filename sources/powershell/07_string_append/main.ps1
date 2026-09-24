# task 07 string_append — expected output: 1000000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: .NET strings are immutable, so plain $text += "x" copies the whole string every iteration.
#       That quadratic behaviour is the point of the task, so no growable buffer is substituted.

$text = ""

for ([int]$i = 0; $i -lt 1000000; $i++) {
    $text += "x"
}

Write-Output $text.Length
