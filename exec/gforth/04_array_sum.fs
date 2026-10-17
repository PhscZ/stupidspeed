\ task 04 array_sum — expected output: 599999940000000
\ build: none (gforth interprets the file)    run: gforth 04_array_sum.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ A 10000000-cell region is allocated with ALLOCATE, filled once, then read back twelve
\ times one cell at a time. Forth addresses memory as (address, index) pairs; the cell size
\ is 8 bytes here.

variable arr
variable total
variable i
variable pass

10000000 cells constant NCELLS

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  NCELLS allocate throw arr !
  \ fill
  0 i !
  begin i @ 10000000 < while
    i @ arr @ i @ cells + !
    1 i +!
  repeat
  \ read back, twelve times
  0 total !
  12 pass !
  begin pass @ 0 > while
    0 i !
    begin i @ 10000000 < while
      arr @ i @ cells + @ total +!
      1 i +!
    repeat
    -1 pass +!
  repeat
  ss-report
  total @ . cr
  arr @ free throw
;

main
bye
