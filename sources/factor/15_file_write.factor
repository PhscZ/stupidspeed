! task 15 file_write — expected output: 52428800
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 15_file_write.factor    (from sources/factor/)
! note: a 1 MiB byte array (the bytes 0..255 repeated 4096 times) written 50 times to
!       out.bin, then flushed and fsynced. Factor's file streams are buffered ports, so
!       `flush` drains the buffer through WriteFile and FlushFileBuffers forces the 50 MiB
!       out to disk; the FFI binding is declared here because windows.kernel32 in this
!       release has no FlushFileBuffers (the declaration is commented out there). `write`
!       has effect ( seq -- ) and writes the whole sequence or throws, so the printed byte
!       count is the buffer length times 50.

USING: accessors alien.c-types alien.syntax byte-arrays io io.encodings.binary io.files
kernel locals math namespaces prettyprint sequences windows.errors windows.kernel32
windows.types ;
IN: scratchpad

LIBRARY: kernel32
FUNCTION: BOOL FlushFileBuffers ( HANDLE hFile )

:: file-write ( -- n )
    1048576 <byte-array> :> buf
    1048576 [| i | i 256 mod i buf set-nth ] each-integer
    "out.bin" binary [
        50 [ buf write ] times
        flush
        output-stream get handle>> handle>> FlushFileBuffers win32-error=0/f
    ] with-file-writer
    buf length 50 * ;

file-write .
