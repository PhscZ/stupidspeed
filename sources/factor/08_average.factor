! task 08 average — expected output: 0.498046875
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 08_average.factor    (from sources/factor/)
! note: doubles. Every reading is a multiple of 1/256 and the running total is a multiple
!       of 1/256 below 2^53, so the sum is exact and the printed digits do not depend on
!       the order the readings are added in.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: average ( -- f )
    0.0 100000000 [| total i |
        i 256 mod 256.0 / total +
    ] each-integer
    100000000 / ;

nano-count average ss-report .
