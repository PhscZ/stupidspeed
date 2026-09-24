# task 03 func_sum — expected output: 100000000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: PowerShell is interpreted, so Add-One is a genuine call on every iteration; there is no
#       inliner that could fold the loop away, and no no-inline attribute is needed.
# note: 100 M interpreted calls run far past the 300 s benchmark timeout under Windows PowerShell 5.1.
#       That is a documented result, not a bug.

function Add-One {
    param([long]$n)
    return $n + 1
}

[long]$value = 0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    $value = Add-One $value
}

Write-Output $value
