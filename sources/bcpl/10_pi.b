// task 10 pi — expected output: 44889
// build: cintsys64 -c bcpl 10_pi.b to 10_pi    run: cintsys64 -c 10_pi
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: BCPL has no big integers, so the spigot's state is hand-written big integers, as
//       the C row of this benchmark does it. A big integer is a getvec vector whose word 0
//       holds the limb count and whose words 1..n hold the limbs, least significant first,
//       base 1e9. Every quantity the spigot carries is non-negative, so there is no sign to
//       keep. Only the four operations the spigot needs are here: add, subtract, multiply
//       by a small integer, and a quotient, which is only ever one or two decimal digits and
//       so comes out of repeated subtraction.
// note: base 1e9 is used because a limb times a small multiplier has to fit in a word, and
//       the multipliers here reach a few hundred thousand. That needs 64-bit words, so this
//       task is 64-bit only; under the 32-bit cintsys the products would wrap.
// note: the digits themselves are never printed, only their sum.

SECTION "10_pi"

GET "libhdr"

MANIFEST {
LIMBS = 2500
BASE  = 1000000000
}

// b!0 is the limb count, b!1..b!n are the limbs, least significant first, base BASE.

LET bigset(b, v) BE
{ LET n = 0
  WHILE v > 0 DO
  { n := n + 1
    b!n := v REM BASE
    v := v / BASE
  }
  b!0 := n
}

LET bigcopy(r, a) BE
{ LET n = a!0
  LET i = 0
  FOR i = 1 TO n DO r!i := a!i
  r!0 := n
}

LET bigcmp(a, b) = VALOF
{ LET an, bn = a!0, b!0
  LET i = 0
  IF an ~= bn DO RESULTIS an < bn -> -1, 1
  FOR i = an TO 1 BY -1 DO
  { IF a!i ~= b!i DO RESULTIS a!i < b!i -> -1, 1
  }
  RESULTIS 0
}

LET bigadd(r, a, b) BE
{ LET an, bn = a!0, b!0
  LET n = an > bn -> an, bn
  LET carry = 0
  LET i = 0
  FOR i = 1 TO n DO
  { LET s = carry
    IF i <= an DO s := s + a!i
    IF i <= bn DO s := s + b!i
    TEST s >= BASE THEN { s := s - BASE; carry := 1 }
                   ELSE carry := 0
    r!i := s
  }
  IF carry DO
  { n := n + 1
    r!n := carry
  }
  r!0 := n
}

// r = a - b, which requires a >= b
LET bigsub(r, a, b) BE
{ LET an, bn = a!0, b!0
  LET borrow = 0
  LET n = 0
  LET i = 0
  FOR i = 1 TO an DO
  { LET bi = borrow
    IF i <= bn DO bi := bi + b!i
    TEST a!i >= bi THEN { r!i := a!i - bi; borrow := 0 }
                   ELSE { r!i := a!i + BASE - bi; borrow := 1 }
  }
  n := an
  WHILE (n > 0) & (r!n = 0) DO n := n - 1
  r!0 := n
}

// r = a * m, m a small integer
LET bigmul(r, a, m) BE
{ LET an = a!0
  LET carry = 0
  LET n = 0
  LET i = 0
  IF (m = 0) | (an = 0) DO
  { r!0 := 0
    RETURN
  }
  FOR i = 1 TO an DO
  { LET p = a!i * m + carry
    r!i := p REM BASE
    carry := p / BASE
  }
  n := an
  WHILE carry > 0 DO
  { n := n + 1
    r!n := carry REM BASE
    carry := carry / BASE
  }
  r!0 := n
}

// floor(u/v) for v > 0, by counting how many times v fits into u. w is scratch space.
LET bigquot(u, v, w) = VALOF
{ LET q = 0
  IF v!0 = 0 DO RESULTIS 0
  bigcopy(w, v)
  WHILE bigcmp(u, w) >= 0 DO
  { q := q + 1
    bigadd(w, w, v)
  }
  RESULTIS q
}

// Gibbons' unbounded spigot.
//   while digits < n:
//     if 4q + r < (n+1)t:  yield n;  q,r,t = 10q, 10(r - n t), t;  n = 10(3q+r)/t - 10n
//     else:                q,r,t = qk, (2q+r)l, t l;              k,l,n = k+1, l+2, ...
LET start() = VALOF
{ LET q = getvec(LIMBS)
  LET r = getvec(LIMBS)
  LET t = getvec(LIMBS)
  LET u = getvec(LIMBS)
  LET v = getvec(LIMBS)
  LET w = getvec(LIMBS)
  LET k, l, n = 1, 3, 3
  LET sum = 0
  LET produced = 0
  LET next = 0

  bigset(q, 1)
  bigset(r, 0)
  bigset(t, 1)

  WHILE produced < 10000 DO
  { bigmul(u, q, 4)
    bigadd(u, u, r)                 // u = 4q + r
    bigmul(v, t, n + 1)             // v = (n + 1)t

    TEST bigcmp(u, v) < 0 THEN
    { // the digit n is settled
      sum := sum + n
      produced := produced + 1

      bigmul(u, q, 3)
      bigadd(u, u, r)
      bigmul(u, u, 10)              // u = 10(3q + r)
      next := bigquot(u, t, w) - 10 * n

      bigmul(v, t, n)               // v = n t
      bigsub(v, r, v)               // v = r - n t
      bigmul(r, v, 10)              // r = 10(r - n t)
      bigmul(q, q, 10)              // q = 10q, t is unchanged

      n := next
    }
    ELSE
    { // not settled yet, so widen the state by one more term
      bigmul(u, q, 7 * k + 2)
      bigmul(v, r, l)
      bigadd(u, u, v)               // u = q(7k + 2) + r l
      bigmul(v, t, l)               // v = t l
      next := bigquot(u, v, w)

      bigmul(u, q, 2)
      bigadd(u, u, r)
      bigmul(u, u, l)               // u = (2q + r) l
      bigcopy(r, u)
      bigmul(q, q, k)
      bigmul(t, t, l)

      k := k + 1
      l := l + 2
      n := next
    }
  }

  writef("%n*n", sum)
  RESULTIS 0
}
