\ task 12 matrix_add — expected output: 999000000
\ build: none (gforth interprets the file)    run: gforth 12_matrix_add.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ Three 1000x1000 matrices as flat allocated regions indexed i*n+j.

1000 constant N
N N * constant SIZE
variable A
variable B
variable C
variable total
variable i
variable j

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
  \ build
  0 i !
  begin i @ N < while
    0 j !
    begin j @ N < while
      i @ j @ +  A @ i @ N * j @ + cells + !
      i @ j @ -  B @ i @ N * j @ + cells + !
      1 j +!
    repeat
    1 i +!
  repeat
  \ add
  0 i !
  begin i @ SIZE < while
    A @ i @ cells + @  B @ i @ cells + @ +  C @ i @ cells + !
    1 i +!
  repeat
  \ sum
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
