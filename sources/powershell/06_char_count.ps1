# task 06 char_count — expected output: 10000000
# build: (none; interpreted)    run: powershell -File 06_char_count.ps1  (PowerShell 7: pwsh -File 06_char_count.ps1)
# note: the 100 MB string is built in one operation ("abcdefghij" * 10000000), never by appending.
# note: scanning 100 M characters one at a time runs past the 300 s benchmark timeout under
#       Windows PowerShell 5.1. That is a documented result, not a bug.

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

Write-Output $count
