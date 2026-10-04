\ task 10 pi — expected output: 4470
\ build: none (gforth interprets the file)
\ run:   gforth 10_pi.fs                (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Gibbons' unbounded spigot, the same algorithm as sources/c/10_pi.c and the
\ same hand-written big integers: sign-magnitude, little-endian, base 1e9 limbs, one limb
\ per 64-bit cell. gforth has no arbitrary-precision library, so the six operations the
\ spigot needs are written out here: add, subtract, multiply by a small integer, compare,
\ and a quotient from repeated subtraction (the spigot only ever asks for a quotient below
\ 100, and the C row does exactly the same).
\
\ The arithmetic argument that makes 64 bits enough, the same one the C row records: the
\ largest multiplier the spigot ever uses at 1000 digits is 7*k+2 with k reaching 3314,
\ i.e. 23200, so limb*multiplier+carry is at most 999999999*23200 + 23200, about 2.3e13,
\ far below 2^63. The measured high-water mark of the state at 1000 digits is 1248 limbs,
\ so the arenas below are 4096 limbs each, three times the observed maximum.
\
\ A bignum is an address x:
\   x @                 limb count n, with no leading zero limbs
\   x cell+ @           sign, 0 or 1
\   x 2 + cells + i cells +     limb i, 0 <= limb < 1e9, limb 0 least significant
\
\ The digits themselves are never printed, only their sum.

4096 constant MAXLIMB
MAXLIMB 4 + cells constant BIGSIZE

: newbig ( -- addr )
  BIGSIZE allocate throw
  0 over !
  0 over cell+ !
;

variable Q
variable R
variable T
variable U
variable V
variable W

newbig Q !
newbig R !
newbig T !
newbig U !
newbig V !
newbig W !

: blimb ( x i -- addr )  2 + cells + ;

\ ---- scratch registers ---------------------------------------------------
variable A
variable B
variable RR
variable AN
variable BN
variable NN
variable CY
variable BR
variable WI
variable M
variable SA
variable SB
variable X
variable Y
variable S
variable D
variable VV
variable QA
variable QB

\ ---- primitives ----------------------------------------------------------

: btrim ( x -- )                       \ drop leading zero limbs, and the sign of a zero
  X !
  begin
    X @ @ 0<> X @ @ 1- X @ swap blimb @ 0= and
  while
    X @ @ 1- X @ !
  repeat
  X @ @ 0= if 0 X @ cell+ ! then
;

: bset ( x v -- )                      \ x = v, v >= 0
  VV ! A !
  0 A @ !
  0 A @ cell+ !
  begin VV @ 0<> while
    VV @ 1000000000 mod  A @ A @ @ blimb  !
    A @ @ 1+ A @ !
    VV @ 1000000000 / VV !
  repeat
;

: bcopy ( src dst -- )
  D ! S !
  S @ @ D @ !
  S @ cell+ @ D @ cell+ !
  S @ @ 0 ?do
    S @ i blimb @  D @ i blimb !
  loop
;

: bcmp_mag ( a b -- -1|0|1 )           \ compare magnitudes
  Y ! X !
  X @ @ Y @ @ <> if
    X @ @ Y @ @ < if -1 else 1 then exit
  then
  X @ @ 0 ?do
    X @ @ 1- i -
    dup X @ swap blimb @
    over Y @ swap blimb @
    2dup <> if
      2dup < if drop drop drop -1 else drop drop drop 1 then
      \ gforth 0.7.9 does not pop the DO-loop frame on EXIT, so leaving the ?DO loop
      \ early needs an explicit UNLOOP first: a bare EXIT here crashes the interpreter.
      unloop exit
    then
    drop drop drop
  loop
  0
;

: bcmp ( a b -- -1|0|1 )               \ compare signed values
  Y ! X !
  X @ cell+ @ Y @ cell+ @ <> if
    X @ cell+ @ if -1 else 1 then exit
  then
  X @ Y @ bcmp_mag
  X @ cell+ @ if negate then
;

: badd_mag ( a b r -- )                \ r = |a| + |b|
  RR ! B ! A !
  A @ @ AN !  B @ @ BN !
  AN @ BN @ max 1+ NN !
  0 RR @ !
  0 RR @ cell+ !
  0 CY !
  NN @ 0 ?do
    CY @
    i AN @ < if A @ i blimb @ else 0 then +
    i BN @ < if B @ i blimb @ else 0 then +
    dup 1000000000 >= if 1000000000 - 1 CY ! else 0 CY ! then
    RR @ i blimb !
  loop
  NN @ RR @ !
  RR @ btrim
;

: bsub_mag ( a b r -- )                \ r = |a| - |b|, needs |a| >= |b|
  RR ! B ! A !
  A @ @ AN !  B @ @ BN !
  0 RR @ !
  0 RR @ cell+ !
  0 BR !
  AN @ 0 ?do
    i BN @ < if B @ i blimb @ else 0 then  BR @ +
    A @ i blimb @
    over >= if
      0 BR !
      A @ i blimb @ swap -
    else
      1 BR !
      1000000000 A @ i blimb @ + swap -
    then
    RR @ i blimb !
  loop
  AN @ RR @ !
  RR @ btrim
;

: badd ( a b r -- )                    \ r = a + b
  RR ! B ! A !
  A @ cell+ @ SA !
  B @ cell+ @ SB !
  SA @ SB @ = if
    A @ B @ RR @ badd_mag
    SA @ RR @ cell+ !
    RR @ btrim exit
  then
  A @ B @ bcmp_mag 0>= if
    A @ B @ RR @ bsub_mag
    SA @ RR @ cell+ !
  else
    B @ A @ RR @ bsub_mag
    SB @ RR @ cell+ !
  then
  RR @ btrim
;

: bsub ( a b r -- )                    \ r = a - b
  RR ! B ! A !
  A @ cell+ @ SA !
  B @ cell+ @ SB !
  SA @ SB @ <> if
    A @ B @ RR @ badd_mag
    SA @ RR @ cell+ !
    RR @ btrim exit
  then
  A @ B @ bcmp_mag 0>= if
    A @ B @ RR @ bsub_mag
    SA @ RR @ cell+ !
  else
    B @ A @ RR @ bsub_mag
    SB @ 0= RR @ cell+ !
  then
  RR @ btrim
;

: bmul_small ( a m r -- )              \ r = a * m, m >= 0
  RR ! M ! A !
  A @ @ AN !
  A @ cell+ @ SA !
  0 RR @ cell+ !
  A @ @ 0= M @ 0= or if
    0 RR @ !
    exit
  then
  AN @ WI !
  0 CY !
  AN @ 0 ?do
    A @ i blimb @ M @ * CY @ +
    dup 1000000000 mod  RR @ i blimb !
    1000000000 / CY !
  loop
  begin CY @ 0<> while
    CY @ 1000000000 mod  RR @ WI @ blimb !
    CY @ 1000000000 / CY !
    WI @ 1+ WI !
  repeat
  WI @ RR @ !
  SA @ RR @ cell+ !
  RR @ btrim
;

: bquot ( a b -- q )                   \ floor(a/b), a >= 0, b > 0, by repeated subtraction
  QB ! QA !
  QA @ cell+ @ 0<> QB @ cell+ @ 0<> or QB @ @ 0= or if 0 exit then
  QB @ W @ bcopy
  0
  begin
    QA @ W @ bcmp_mag 0>=
  while
    1+
    W @ QB @ W @ badd_mag
  repeat
;

\ ---- the spigot ----------------------------------------------------------

variable k
variable l
variable n
variable total
variable produced
variable next

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  Q @ 1 bset
  R @ 0 bset
  T @ 1 bset
  1 k !  3 l !  3 n !  0 total !  0 produced !
  begin produced @ 1000 < while
    Q @ 4 U @ bmul_small
    U @ R @ U @ badd                   \ u = 4q + r
    T @ n @ 1+ V @ bmul_small          \ v = (n+1) t
    U @ V @ bcmp 0< if
      \ the digit n is settled
      n @ total +!
      produced @ 1+ produced !
      Q @ 3 U @ bmul_small
      U @ R @ U @ badd                 \ u = 3q + r
      U @ 10 U @ bmul_small            \ u = 10(3q + r)
      U @ T @ bquot 10 n @ * - next !
      T @ n @ V @ bmul_small           \ v = n t
      R @ V @ V @ bsub                 \ v = r - n t
      V @ 10 R @ bmul_small            \ r = 10(r - n t)
      Q @ 10 Q @ bmul_small            \ q = 10q
      next @ n !
    else
      \ not settled yet: widen the state by one more term
      Q @ 7 k @ * 2 + U @ bmul_small
      R @ l @ V @ bmul_small
      U @ V @ U @ badd                 \ u = q(7k + 2) + r l
      T @ l @ V @ bmul_small           \ v = t l
      U @ V @ bquot next !
      Q @ 2 U @ bmul_small
      U @ R @ U @ badd                 \ u = 2q + r
      U @ l @ U @ bmul_small           \ u = (2q + r) l
      U @ R @ bcopy                    \ r = u
      Q @ k @ Q @ bmul_small           \ q = q k
      T @ l @ T @ bmul_small           \ t = t l
      k @ 1+ k !
      l @ 2 + l !
      next @ n !
    then
  repeat
  ss-report
  total @ . cr
;

main
bye
