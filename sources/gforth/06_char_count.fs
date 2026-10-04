\ task 06 char_count — expected output: 10000000
\ build: none (gforth interprets the file)
\ run:   gforth 06_char_count.fs         (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ The 100 MB text is built once by filling a buffer with the 10-byte block repeated, so
\ the build is not the benchmark, and the scan walks it one byte at a time.
\ Character literals are written 'c' in gforth; this build has no [CHAR] word.

100000000 constant TEXTLEN
variable text
variable count
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
  TEXTLEN allocate throw text !
  \ build "abcdefghij" repeated: 'a' + (i mod 10)
  0 i !
  begin i @ TEXTLEN < while
    'a' i @ 10 mod +
    text @ i @ + c!
    1 i +!
  repeat
  \ scan for 'h'
  0 count !
  0 i !
  begin i @ TEXTLEN < while
    text @ i @ + c@ 'h' = if 1 count +! then
    1 i +!
  repeat
  ss-report
  count @ . cr
  text @ free throw
;

main
bye
