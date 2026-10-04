! task 01 branches — expected output: 33333334 13333333 7619048 45714285
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 01_branches.factor    (from sources/factor/)
! note: Factor locals are immutable, so the four counters live on the data stack: the
!       quotation handed to each-integer binds the counters and the index out of the
!       stack and leaves the updated counters there for the next iteration.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: arrays io kernel locals math math.parser namespaces sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

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

nano-count branches 4array ss-report [ number>string ] map " " join print
