! task 04 array_sum — expected output: 499999500000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 04_array_sum.factor    (from sources/factor/)
! note: one plain array of a million fixnums, filled and then read back in order.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: arrays io kernel locals math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

:: array-sum ( -- total )
    1000000 0 <array> :> a
    1000000 [| i | i i a set-nth ] each-integer
    0 1000000 [| total i | total i a nth + ] each-integer ;

nano-count array-sum ss-report .
