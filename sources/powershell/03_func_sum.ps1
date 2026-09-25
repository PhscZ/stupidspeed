# task 03 func_sum — expected output: 100000000
# build: (none; interpreted)    run: powershell -File 03_func_sum.ps1  (PowerShell 7: pwsh -File 03_func_sum.ps1)
# note: PowerShell is interpreted, so Add-One is a genuine call on every iteration; there is no
#       inliner that could fold the loop away, and no no-inline attribute is needed.
# note: 100 M interpreted calls are much slower still under Windows PowerShell 5.1: a
#       function call costs several times what a loop iteration does. A result, not a bug.

function Add-One {
    param([long]$n)
    return $n + 1
}

[long]$value = 0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    $value = Add-One $value
}

Write-Output $value
