! task 03 func_sum — expected output: 100000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 03_func_sum.factor    (from sources/factor/)
! note: Factor has no no-inline marker, and its optimizing compiler is free to inline a
!       word this small, so the hundred million calls may collapse into the loop. The call
!       is written out anyway; `times` is the counter loop.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: io kernel math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

: add-one ( n -- n ) 1 + ;

: func-sum ( -- value )
    0 100000000 [ add-one ] times ;

nano-count func-sum ss-report .
