! task 14 file_read — expected output: 2389704704
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 14_file_read.factor    (from sources/factor/)
! note: reads data.bin (50 MiB, the bytes 0..255 over and over) from the working directory
!       in 1 MiB chunks and sums every byte. The chunk loop is a tail-recursive word: `read`
!       returns f at end of file, which the `if` takes as its false branch, so the recursion
!       is 50 deep. 4294967296 is 2^32 and Factor's integers are arbitrary precision, so the
!       final modulo is a real reduction rather than a wrapping overflow.

USING: io io.encodings.binary io.files kernel math prettyprint sequences ;
IN: scratchpad

: read-chunks ( total -- total )
    1048576 read dup [ sum + read-chunks ] [ drop ] if ;

: file-read ( -- total )
    "data.bin" binary [ 0 read-chunks 4294967296 mod ] with-file-reader ;

file-read .
