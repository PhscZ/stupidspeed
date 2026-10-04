\ task 15 file_write — expected output: 52428800
\ build: none (gforth interprets the file)    run: gforth 15_file_write.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ Written in binary mode ("wb") in 1 MiB chunks. gforth has no fsync word, so the flush is
\ CLOSE-FILE, the deviation the Tcl, D, Julia and other rows already record.

1048576 constant CHUNK
variable fid
variable buf
variable i
variable written

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  s" out.bin" w/o create-file throw fid !
  CHUNK allocate throw buf !
  \ fill the chunk with bytes 0..255 repeated
  0 i !
  begin i @ CHUNK < while
    i @ 256 mod  buf @ i @ + c!
    1 i +!
  repeat
  \ write it 50 times
  0 written !
  begin written @ 50 < while
    buf @ CHUNK fid @ write-file throw
    1 written +!
  repeat
  fid @ close-file throw
  ss-report
  CHUNK 50 * . cr
  buf @ free throw
;

main
bye
