\ task 13 matrix_mul — expected output: 599995000
\ build: none (gforth interprets the file)    run: gforth 13_matrix_mul.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ The plain triple loop over flat 500x500 matrices, no reordering and no blocking.

500 constant N
N N * constant SIZE
variable A
variable B
variable C
variable total
variable i
variable j
variable k
variable acc

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  SIZE cells allocate throw A !
  SIZE cells allocate throw B !
  SIZE cells allocate throw C !
  0 i !
  begin i @ N < while
    0 j !
    begin j @ N < while
      i @ j @ + 7 mod  A @ i @ N * j @ + cells + !
      i @ j @ * 5 mod  B @ i @ N * j @ + cells + !
      1 j +!
    repeat
    1 i +!
  repeat
  0 i !
  begin i @ N < while
    0 j !
    begin j @ N < while
      0 acc !
      0 k !
      begin k @ N < while
        A @ i @ N * k @ + cells + @
        B @ k @ N * j @ + cells + @
        * acc +!
        1 k +!
      repeat
      acc @  C @ i @ N * j @ + cells + !
      1 j +!
    repeat
    1 i +!
  repeat
  0 total !
  0 i !
  begin i @ SIZE < while
    C @ i @ cells + @ total +!
    1 i +!
  repeat
  ss-report
  total @ . cr
  A @ free throw  B @ free throw  C @ free throw
;

main
bye
