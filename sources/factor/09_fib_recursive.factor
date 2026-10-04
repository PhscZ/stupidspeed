! task 09 fib_recursive — expected output: 102334155
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 09_fib_recursive.factor    (from sources/factor/)
! note: naive recursion, about 331 million calls. Factor compiles the two self-calls into
!       real calls; nothing is memoized.

! timing: nano-count is Factor's monotonic nanosecond clock; TIME_MS is written to stderr
!         through error-stream, and stdout is unchanged.
USING: combinators io kernel math math.parser namespaces prettyprint sequences system ;
IN: scratchpad

: ss-report ( t0 value -- value )
    swap nano-count swap - 1000000 /i number>string
    "TIME_MS=" swap append "\n" append error-stream get stream-write ;

: fib ( n -- n )
    dup 2 < [ ] [ [ 1 - fib ] [ 2 - fib ] bi + ] if ;

nano-count 40 fib ss-report .
