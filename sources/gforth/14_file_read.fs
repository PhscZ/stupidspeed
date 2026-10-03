\ task 14 file_read — expected output: 2389704704
\ build: none (gforth interprets the file)    run: gforth 14_file_read.fs
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ The file is opened in binary read mode ("rb") and read in 1 MiB chunks, each chunk then
\ scanned one byte at a time. Forth file access is the ANS file wordset: R/O OPEN-FILE,
\ READ-FILE, CLOSE-FILE.

52428800 constant FILESIZE
1048576 constant CHUNK

variable fid
variable buf
variable total
variable got
variable i

: main
  s" data.bin" r/o open-file throw fid !
  CHUNK allocate throw buf !
  0 total !
  begin
    buf @ CHUNK fid @ read-file throw  got !
    got @ 0>
  while
    0 i !
    begin i @ got @ < while
      buf @ i @ + c@ total +!
      1 i +!
    repeat
  repeat
  fid @ close-file throw
  total @ 4294967296 mod . cr
  buf @ free throw
;

main
bye
