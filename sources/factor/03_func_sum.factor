! task 03 func_sum — expected output: 100000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 03_func_sum.factor    (from sources/factor/)
! note: Factor has no no-inline marker, and its optimizing compiler is free to inline a
!       word this small, so the hundred million calls may collapse into the loop. The call
!       is written out anyway; `times` is the counter loop.

USING: math prettyprint ;
IN: scratchpad

: add-one ( n -- n ) 1 + ;

: func-sum ( -- value )
    0 100000000 [ add-one ] times ;

func-sum .
