! task 08 average — expected output: 0.498046875
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 08_average.factor    (from sources/factor/)
! note: doubles. Every reading is a multiple of 1/256 and the running total is a multiple
!       of 1/256 below 2^53, so the sum is exact and the printed digits do not depend on
!       the order the readings are added in.

USING: locals math prettyprint ;
IN: scratchpad

:: average ( -- f )
    0.0 100000000 [| total i |
        i 256 mod 256.0 / total +
    ] each-integer
    100000000 / ;

average .
