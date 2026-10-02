! task 09 fib_recursive — expected output: 102334155
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 09_fib_recursive.factor    (from sources/factor/)
! note: naive recursion, about 331 million calls. Factor compiles the two self-calls into
!       real calls; nothing is memoized.

USING: combinators kernel math prettyprint ;
IN: scratchpad

: fib ( n -- n )
    dup 2 < [ ] [ [ 1 - fib ] [ 2 - fib ] bi + ] if ;

40 fib .
