\ task 07 string_append — expected output: 250000
\ build: none (gforth interprets the file)
\ run:   gforth 07_string_append.fs      (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ The accumulator is a heap buffer that is reallocated to one byte longer on every append
\ and has the new byte written at the end, so each step copies the whole accumulator: the
\ loop is quadratic, which is what the task measures. RESIZE is gforth's realloc, so the
\ old contents are copied for us, which is the same copy the C row's realloc does.
\ Character literals are written 'c' in gforth; this build has no [CHAR] word.

variable len
variable text

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  0 len !
  \ start with a 1-byte buffer so the address is never 0
  1 allocate throw text !
  begin
    len @ 250000 <
  while
    text @ len @ 1+ resize throw text !
    'x' text @ len @ + c!
    1 len +!
  repeat
  ss-report
  len @ . cr
  text @ free throw
;

main
bye
