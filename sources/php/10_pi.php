<?php
// task 10 pi — expected output: 44889
// build: none (interpreted)    run: php 10_pi.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 10_pi.php (zend + jit)
// Gibbons' unbounded spigot. PHP has no built-in arbitrary-precision integers — bcmath and gmp
// are optional extensions and are not enabled in the stock Windows configuration — so q, r and
// t are hand-written big integers: base-10^9 limb arrays with a sign, carrying exactly the
// operations the spigot needs. The leading 3 is the first digit emitted and counts toward the
// 10000; only their sum is printed, never the digits.

const BASE = 1000000000;

// A big integer is a little-endian limb array with the sign appended as its last element:
// [limb0, limb1, ..., limbN-1, sign].  The top limb is never zero, so zero is [0].
// Limb values are below 10^9, which leaves every product used here inside a 64-bit int.

function bint(int $v): array
{
    if ($v === 0) {
        return [0];
    }
    $sign = 1;
    if ($v < 0) {
        $sign = -1;
        $v = -$v;
    }
    $out = [];
    while ($v > 0) {
        $out[] = $v % BASE;
        $v = intdiv($v, BASE);
    }
    $out[] = $sign;
    return $out;
}

function bnorm(array $limbs, int $sign): array
{
    $n = count($limbs);
    while ($n > 0 && $limbs[$n - 1] === 0) {
        $n--;
    }
    if ($n === 0) {
        return [0];
    }
    if ($n !== count($limbs)) {
        $limbs = array_slice($limbs, 0, $n);
    }
    $limbs[] = $sign;
    return $limbs;
}

function bneg(array $a): array
{
    $n = count($a) - 1;
    if ($n === 0) {
        return $a;
    }
    $a[$n] = -$a[$n];
    return $a;
}

// Compares magnitudes, ignoring the sign element.
function bcmpmag(array $a, array $b): int
{
    $na = count($a) - 1;
    $nb = count($b) - 1;
    if ($na !== $nb) {
        return $na < $nb ? -1 : 1;
    }
    for ($i = $na - 1; $i >= 0; $i--) {
        if ($a[$i] !== $b[$i]) {
            return $a[$i] < $b[$i] ? -1 : 1;
        }
    }
    return 0;
}

function bcmp(array $a, array $b): int
{
    $na = count($a) - 1;
    $nb = count($b) - 1;
    $sa = $a[$na];
    $sb = $b[$nb];
    if ($sa !== $sb) {
        return $sa < $sb ? -1 : 1;
    }
    if ($sa === 0) {
        return 0;
    }
    $c = bcmpmag($a, $b);
    return $sa > 0 ? $c : -$c;
}

function badd(array $a, array $b): array
{
    $na = count($a) - 1;
    $nb = count($b) - 1;
    $sa = $a[$na];
    $sb = $b[$nb];
    if ($sa === 0) {
        return $b;
    }
    if ($sb === 0) {
        return $a;
    }
    if ($sa === $sb) {
        $n = $na > $nb ? $na : $nb;
        $out = [];
        $carry = 0;
        for ($i = 0; $i < $n; $i++) {
            $s = ($i < $na ? $a[$i] : 0) + ($i < $nb ? $b[$i] : 0) + $carry;
            if ($s >= BASE) {
                $s -= BASE;
                $carry = 1;
            } else {
                $carry = 0;
            }
            $out[] = $s;
        }
        if ($carry !== 0) {
            $out[] = $carry;
        }
        return bnorm($out, $sa);
    }
    $c = bcmpmag($a, $b);
    if ($c === 0) {
        return [0];
    }
    if ($c > 0) {
        $big = $a;
        $small = $b;
        $sign = $sa;
    } else {
        $big = $b;
        $small = $a;
        $sign = $sb;
    }
    $nbig = count($big) - 1;
    $nsmall = count($small) - 1;
    $out = [];
    $borrow = 0;
    for ($i = 0; $i < $nbig; $i++) {
        $d = $big[$i] - ($i < $nsmall ? $small[$i] : 0) - $borrow;
        if ($d < 0) {
            $d += BASE;
            $borrow = 1;
        } else {
            $borrow = 0;
        }
        $out[] = $d;
    }
    return bnorm($out, $sign);
}

function bsub(array $a, array $b): array
{
    return badd($a, bneg($b));
}

// Multiplies by a machine integer.
function bmul(array $a, int $m): array
{
    $n = count($a) - 1;
    if ($n === 0 || $m === 0) {
        return [0];
    }
    $sign = $a[$n];
    if ($m < 0) {
        $m = -$m;
        $sign = -$sign;
    }
    $out = [];
    $carry = 0;
    for ($i = 0; $i < $n; $i++) {
        $p = $a[$i] * $m + $carry;
        $carry = intdiv($p, BASE);
        $out[] = $p - $carry * BASE;
    }
    while ($carry > 0) {
        $out[] = $carry % BASE;
        $carry = intdiv($carry, BASE);
    }
    return bnorm($out, $sign);
}

// floor(|a| / d) for d > 0, with the quotient below 2^31. The leading limbs give an estimate
// within a couple of units, which is then corrected exactly with full multiplications.
function bdivqmag(array $a, array $d): int
{
    $na = count($a) - 1;
    $nd = count($d) - 1;
    if ($na < $nd) {
        return 0;
    }
    $ah = $na >= 2 ? $a[$na - 1] * BASE + $a[$na - 2] : $a[0];
    $dh = $nd >= 2 ? $d[$nd - 1] * BASE + $d[$nd - 2] : $d[0];
    // |a| and d are ah and dh scaled by BASE to the powers below, so the ratio of the leading
    // limbs is the quotient to within a couple of units. A one-limb number is exact as it is.
    $scale = ($na >= 2 ? $na - 2 : 0) - ($nd >= 2 ? $nd - 2 : 0);
    $est = (int) floor((float) $ah / (float) $dh * pow((float) BASE, $scale));
    if ($est < 0) {
        $est = 0;
    }
    while ($est > 0 && bcmpmag(bmul($d, $est), $a) > 0) {
        $est = intdiv($est, 2);
    }
    $lo = $est;
    $hi = $est + 1;
    while ($hi <= 1073741824 && bcmpmag(bmul($d, $hi), $a) <= 0) {
        $lo = $hi;
        $hi *= 2;
    }
    while ($hi - $lo > 1) {
        $mid = intdiv($lo + $hi, 2);
        if (bcmpmag(bmul($d, $mid), $a) <= 0) {
            $lo = $mid;
        } else {
            $hi = $mid;
        }
    }
    return $lo;
}

// floor(n / d) for d > 0, with |n / d| below 2^31.
function bdivq(array $n, array $d): int
{
    $nn = count($n) - 1;
    if ($nn === 0) {
        return 0;
    }
    $q = bdivqmag($n, $d);
    if ($n[$nn] > 0) {
        return $q;
    }
    // floor(-A/d) is -ceil(A/d): one below -floor(A/d) unless d divides A exactly.
    $rem = bsub(bneg($n), bmul($d, $q));
    return count($rem) === 1 ? -$q : -$q - 1;
}

$q = bint(1);
$r = bint(0);
$t = bint(1);
$k = 1;
$n = 3;
$l = 3;

$sum = 0;
$emitted = 0;

while ($emitted < 10000) {
    // 4*q + r - t < n*t means n is the next digit of pi.
    $lhs = bsub(badd(bmul($q, 4), $r), $t);
    $rhs = bmul($t, $n);
    if (bcmp($lhs, $rhs) < 0) {
        $sum += $n;
        $emitted++;
        $nextq = bmul($q, 10);
        $nextr = bmul(bsub($r, bmul($t, $n)), 10);
        $nextn = bdivq(bmul(badd(bmul($q, 3), $r), 10), $t) - 10 * $n;
        $q = $nextq;
        $r = $nextr;
        $n = $nextn;
    } else {
        $nextq = bmul($q, $k);
        $nextr = bmul(badd(bmul($q, 2), $r), $l);
        $nextt = bmul($t, $l);
        $nextn = bdivq(badd(bmul($q, 7 * $k + 2), bmul($r, $l)), $nextt);
        $q = $nextq;
        $r = $nextr;
        $t = $nextt;
        $n = $nextn;
        $l += 2;
        $k++;
    }
}

echo $sum, "\n";
