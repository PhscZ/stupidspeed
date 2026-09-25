# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: (none; interpreted)    run: powershell -File 01_branches.ps1  (PowerShell 7: pwsh -File 01_branches.ps1)
# note: every counter is cast to [long]; PowerShell would otherwise promote the arithmetic to double.
# note: a 100 M-iteration loop costs roughly 264 s under Windows PowerShell 5.1 on this machine.

[long]$a = 0
[long]$b = 0
[long]$c = 0
[long]$d = 0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    if ($i % 3 -eq 0) {
        $a++
    }
    elseif ($i % 5 -eq 0) {
        $b++
    }
    elseif ($i % 7 -eq 0) {
        $c++
    }
    else {
        $d++
    }
}

Write-Output "$a $b $c $d"
