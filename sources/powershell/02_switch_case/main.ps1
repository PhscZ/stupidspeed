# task 02 switch_case — expected output: 7500000075000000
# build: (none; interpreted)    run: powershell -File main.ps1  (PowerShell 7: pwsh -File main.ps1)
# note: PowerShell's real switch statement, matching ($i % 4) against the case labels by equality.
# note: a 100 M-iteration loop costs roughly 264 s under Windows PowerShell 5.1 on this machine and
#       may hit the 300 s benchmark timeout. That is a documented result, not a bug.

[long]$acc = 0

for ([long]$i = 0; $i -lt 100000000; $i++) {
    switch ($i % 4) {
        0 { $acc += 1 }
        1 { $acc += $i }
        2 { $acc += 2 * $i }
        3 { $acc += 3 * $i }
    }
}

Write-Output $acc
