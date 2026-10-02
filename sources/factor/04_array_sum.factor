! task 04 array_sum — expected output: 499999500000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 04_array_sum.factor    (from sources/factor/)
! note: one plain array of a million fixnums, filled and then read back in order.

USING: arrays locals math prettyprint sequences ;
IN: scratchpad

:: array-sum ( -- total )
    1000000 0 <array> :> a
    1000000 [| i | i i a set-nth ] each-integer
    0 1000000 [| total i | total i a nth + ] each-integer ;

array-sum .
