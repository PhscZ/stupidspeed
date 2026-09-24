# task 10 pi — expected output: 44889
# build: (none; interpreted)    run: powershell -File 10_pi.ps1  (PowerShell 7: pwsh -File 10_pi.ps1)
# note: Gibbons' unbounded spigot on System.Numerics.BigInteger, which both PowerShell 5.1 and 7
#       ship with. BigInteger's "/" truncates toward zero; that was checked against the reference
#       spigot and produces the same digits, so no floor-division helper is needed.
# note: the leading 3 is emitted first and counts as the first of the 10000 digits that are summed.

[System.Numerics.BigInteger]$q = 1
[System.Numerics.BigInteger]$r = 0
[System.Numerics.BigInteger]$t = 1
[System.Numerics.BigInteger]$k = 1
[System.Numerics.BigInteger]$n = 3
[System.Numerics.BigInteger]$l = 3

[long]$sum = 0
[long]$digits = 0

while ($digits -lt 10000) {
    if ((4 * $q + $r - $t) -lt ($n * $t)) {
        # n is a safe digit: emit it, then q, r, n = 10q, 10(r - nt), 10(3q + r)/t - 10n
        $sum += [long]$n
        $digits++
        [System.Numerics.BigInteger]$nextq = 10 * $q
        [System.Numerics.BigInteger]$nextr = 10 * ($r - $n * $t)
        [System.Numerics.BigInteger]$nextn = (10 * (3 * $q + $r)) / $t - 10 * $n
        $q = $nextq
        $r = $nextr
        $n = $nextn
    }
    else {
        # no safe digit yet: q, r, t, k, n, l = qk, (2q + r)l, tl, k + 1, (q(7k + 2) + rl)/(tl), l + 2
        [System.Numerics.BigInteger]$nextq = $q * $k
        [System.Numerics.BigInteger]$nextr = (2 * $q + $r) * $l
        [System.Numerics.BigInteger]$nextt = $t * $l
        [System.Numerics.BigInteger]$nextn = ($q * (7 * $k + 2) + $r * $l) / ($t * $l)
        [System.Numerics.BigInteger]$nextl = $l + 2
        $q = $nextq
        $r = $nextr
        $t = $nextt
        $k = $k + 1
        $n = $nextn
        $l = $nextl
    }
}

Write-Output $sum
