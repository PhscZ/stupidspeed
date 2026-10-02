! task 01 branches — expected output: 33333334 13333333 7619048 45714285
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 01_branches.factor    (from sources/factor/)
! note: Factor locals are immutable, so the four counters live on the data stack: the
!       quotation handed to each-integer binds the counters and the index out of the
!       stack and leaves the updated counters there for the next iteration.

USING: arrays io kernel locals math math.parser sequences ;
IN: scratchpad

:: branches ( -- a b c d )
    0 0 0 0
    100000000 [| a b c d i |
        i 3 mod 0 = [
            a 1 + b c d
        ] [
            i 5 mod 0 = [
                a b 1 + c d
            ] [
                i 7 mod 0 = [
                    a b c 1 + d
                ] [
                    a b c d 1 +
                ] if
            ] if
        ] if
    ] each-integer ;

branches 4array [ number>string ] map " " join print
