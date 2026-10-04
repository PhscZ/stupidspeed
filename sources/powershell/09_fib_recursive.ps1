# task 09 fib_recursive — expected output: 102334155
# build: (none; interpreted)    run: powershell -File 09_fib_recursive.ps1  (PowerShell 7: pwsh -File 09_fib_recursive.ps1)
# note: naive recursion, no memoization; fib(40) is about 331 million calls, which makes
#       this the slowest cell in the row under Windows PowerShell 5.1. The answer is exact.
# timing: [System.Diagnostics.Stopwatch]::GetTimestamp() is the high-resolution counter and
#         GetTimestamp()/Frequency converts it to seconds; TIME_MS goes to stderr with
#         [Console]::Error.WriteLine and stdout is unchanged.
$ssFreq = [System.Diagnostics.Stopwatch]::Frequency
$ssT0 = [System.Diagnostics.Stopwatch]::GetTimestamp()
function Write-SsTime {
    $ms = ([System.Diagnostics.Stopwatch]::GetTimestamp() - $ssT0) * 1000.0 / $ssFreq
    [Console]::Error.WriteLine("TIME_MS=" + $ms.ToString('F3', [System.Globalization.CultureInfo]::InvariantCulture))
}

function Get-Fib {
    param([int]$n)
    if ($n -lt 2) {
        return $n
    }
    return (Get-Fib ($n - 1)) + (Get-Fib ($n - 2))
}

Write-SsTime
Write-Output (Get-Fib 40)
