\ task 03 func_sum — expected output: 100000000
\ build: none (gforth interprets the file)
\ run:   gforth 03_func_sum.fs           (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ The helper lives in its own file, 03_func_sum_add_one.fs, which is included here. INCLUDE
\ resolves a bare name against the directory of the including file as well as the current
\ directory, so the name is enough. Forth has no inliner in the sense a compiler does, but a
\ colon definition is a real call in every gforth build, so the 100 million calls are genuine
\ calls.

include 03_func_sum_add_one.fs

variable value
variable i

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  0 value !
  0 i !
  begin
    i @ 100000000 <
  while
    value @ add_one value !
    1 i +!
  repeat
  ss-report
  value @ . cr
;

main
bye
