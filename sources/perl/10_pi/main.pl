# task 10 pi — expected output: 44889
# build: perl main.pl    run: perl main.pl
# note: Perl's native integers are 64-bit and Math::BigInt is far too slow for 10000 digits, so the
#       Gibbons unbounded spigot runs on hand-written big integers: sign-magnitude arrays of limbs
#       in base 1000000000, with hand-written add, subtract, multiply by a small integer and
#       divide by a big integer (by repeated subtraction of ten times the divisor, then of the
#       divisor). Only the digit sum is printed, never the digits themselves.
use strict;
use warnings;

my $BASE = 1000000000;

# A big integer is a reference to an array: element 0 is the sign (1 = negative, 0 = zero or
# positive), elements 1.. are the limbs, least significant limb first, each below 1000000000, and
# the top limb is never zero. Zero is the one-element array [0].

sub bi_new {
    my ($v) = @_;                       # non-negative native integer
    my @limbs;
    while ($v > 0) {
        my $limb = $v % $BASE;
        push @limbs, $limb;
        $v = ($v - $limb) / $BASE;
    }
    return [0, @limbs];
}

sub bi_copy {
    my ($x) = @_;
    my @copy = @$x;
    return \@copy;
}

sub bi_trim {
    my ($x) = @_;
    pop @$x while $#$x >= 1 && $x->[-1] == 0;
    $x->[0] = 0 if $#$x == 0;           # zero is always positive
    return $x;
}

sub bi_cmp_mag {                        # compare magnitudes, signs ignored
    my ($a, $b) = @_;
    my ($na, $nb) = ($#$a, $#$b);
    return $na <=> $nb if $na != $nb;
    for (my $i = $na; $i >= 1; $i--) {
        return $a->[$i] <=> $b->[$i] if $a->[$i] != $b->[$i];
    }
    return 0;
}

sub bi_cmp {                            # signed comparison
    my ($a, $b) = @_;
    return -1 if $a->[0] && !$b->[0];
    return 1  if !$a->[0] && $b->[0];
    my $c = bi_cmp_mag($a, $b);
    return $a->[0] ? -$c : $c;
}

sub bi_add_mag {                        # magnitude sum
    my ($a, $b) = @_;
    my ($na, $nb) = ($#$a, $#$b);
    my $n = $na > $nb ? $na : $nb;
    my @r = (0);
    my $carry = 0;
    for (my $i = 1; $i <= $n; $i++) {
        my $s = $carry;
        $s += $a->[$i] if $i <= $na;
        $s += $b->[$i] if $i <= $nb;
        if ($s >= $BASE) { $s -= $BASE; $carry = 1 } else { $carry = 0 }
        $r[$i] = $s;
    }
    push @r, 1 if $carry;
    return bi_trim(\@r);
}

sub bi_sub_mag_inplace {                # x -= b on magnitudes only, requires |x| >= |b|
    my ($x, $b) = @_;
    my $nb = $#$b;
    my $borrow = 0;
    for (my $i = 1; $i <= $nb; $i++) {
        my $d = $x->[$i] - $borrow - $b->[$i];
        if ($d < 0) { $x->[$i] = $d + $BASE; $borrow = 1 } else { $x->[$i] = $d; $borrow = 0 }
    }
    my $i = $nb + 1;
    while ($borrow) {
        my $d = $x->[$i] - 1;
        if ($d < 0) { $x->[$i] = $d + $BASE; $i++ } else { $x->[$i] = $d; $borrow = 0 }
    }
    return bi_trim($x);
}

sub bi_sub_mag {                        # magnitude difference, requires |a| >= |b|
    my ($a, $b) = @_;
    my $x = bi_copy($a);
    $x->[0] = 0;
    return bi_sub_mag_inplace($x, $b);
}

sub bi_add {
    my ($a, $b) = @_;
    if ($a->[0] == $b->[0]) {           # same sign: add the magnitudes
        my $r = bi_add_mag($a, $b);
        $r->[0] = $a->[0];
        return bi_trim($r);
    }
    my $c = bi_cmp_mag($a, $b);         # opposite signs: subtract the smaller magnitude
    return [0] if $c == 0;
    if ($c > 0) {
        my $r = bi_sub_mag($a, $b);
        $r->[0] = $a->[0];
        return $r;
    }
    my $r = bi_sub_mag($b, $a);
    $r->[0] = $b->[0];
    return $r;
}

sub bi_sub {
    my ($a, $b) = @_;
    my $neg = bi_copy($b);
    $neg->[0] = $neg->[0] ? 0 : 1 if $#$neg >= 1;   # negate, zero stays positive
    return bi_add($a, $neg);
}

sub bi_mul_small {                      # a * m, m a non-negative native integer
    my ($a, $m) = @_;
    return [0] if $m == 0 || $#$a == 0;
    my $na = $#$a;
    my @r = (0);
    my $carry = 0;
    for (my $i = 1; $i <= $na; $i++) {
        my $p = $a->[$i] * $m + $carry;
        my $limb = $p % $BASE;
        $r[$i] = $limb;
        $carry = ($p - $limb) / $BASE;
    }
    while ($carry > 0) {
        my $limb = $carry % $BASE;
        push @r, $limb;
        $carry = ($carry - $limb) / $BASE;
    }
    $r[0] = $a->[0];
    return bi_trim(\@r);
}

# floor(a / b) for b > 0 and a of either sign. The spigot never asks for a quotient above 99, so the
# division subtracts ten times the divisor as long as it fits and then the divisor itself; that is
# exact for any quotient and costs at most quotient/10 + 9 subtractions.
sub bi_quot_floor {
    my ($a, $b) = @_;
    my $x = bi_copy($a);
    $x->[0] = 0;                        # work on the magnitude of a
    my $b10 = bi_mul_small($b, 10);
    my $q = 0;
    while (bi_cmp_mag($x, $b10) >= 0) { bi_sub_mag_inplace($x, $b10); $q += 10 }
    while (bi_cmp_mag($x, $b) >= 0)   { bi_sub_mag_inplace($x, $b);   $q += 1 }
    if ($a->[0]) {                      # negative numerator: floor rounds away from zero
        $q = -$q;
        $q -= 1 if $#$x >= 1;           # a non-zero remainder means the quotient is not exact
    }
    return $q;
}

my $q = bi_new(1);
my $r = bi_new(0);
my $t = bi_new(1);
my ($k, $l, $n) = (1, 3, 3);

my $sum = 0;

for (my $produced = 0; $produced < 10000; ) {
    my $u = bi_add(bi_mul_small($q, 4), $r);        # u = 4q + r
    my $v = bi_mul_small($t, $n + 1);               # v = (n + 1) t

    if (bi_cmp($u, $v) < 0) {
        # the digit n is settled
        $sum += $n;
        $produced++;

        my $nq = bi_mul_small($q, 10);
        my $nr = bi_mul_small(bi_sub($r, bi_mul_small($t, $n)), 10);
        my $nn = bi_quot_floor(bi_mul_small(bi_add(bi_mul_small($q, 3), $r), 10), $t) - 10 * $n;

        $q = $nq;
        $r = $nr;
        $n = $nn;
    } else {
        # not settled yet: widen the state by one more term
        my $nq  = bi_mul_small($q, $k);
        my $nr  = bi_mul_small(bi_add(bi_mul_small($q, 2), $r), $l);
        my $nt  = bi_mul_small($t, $l);
        my $num = bi_add(bi_mul_small($q, 7 * $k + 2), bi_mul_small($r, $l));
        my $nn  = bi_quot_floor($num, $nt);

        $q = $nq;
        $r = $nr;
        $t = $nt;
        $k = $k + 1;
        $l = $l + 2;
        $n = $nn;
    }
}

print $sum, "\n";
