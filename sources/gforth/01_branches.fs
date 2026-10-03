\ task 01 branches — expected output: 33333334 13333333 7619048 45714285
\ build: none (gforth interprets the file)    run: gforth 01_branches.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ Four counters are held in variables and incremented in the branch bodies. i is kept in a
\ variable as well, because the if/else chain needs the value after the division test.

variable a
variable b
variable c
variable d
variable i

: main
  0 a ! 0 b ! 0 c ! 0 d !
  0 i !
  begin
    i @ 100000000 <
  while
    i @ 3 mod 0= if
      1 a +!
    else
      i @ 5 mod 0= if
        1 b +!
      else
        i @ 7 mod 0= if
          1 c +!
        else
          1 d +!
        then
      then
    then
    1 i +!
  repeat
  a @ . b @ . c @ . d @ . cr
;

main
bye
