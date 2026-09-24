# task 09 fib_recursive — expected output: 102334155
# build: (none; interpreted)    run: powershell -File 09_fib_recursive.ps1  (PowerShell 7: pwsh -File 09_fib_recursive.ps1)
# note: naive recursion, no memoization; fib(40) is about 331 million calls, far past the 300 s
#       benchmark timeout under Windows PowerShell 5.1 (a documented DNF). The answer is exact.

function Get-Fib {
    param([int]$n)
    if ($n -lt 2) {
        return $n
    }
    return (Get-Fib ($n - 1)) + (Get-Fib ($n - 2))
}

Write-Output (Get-Fib 40)
