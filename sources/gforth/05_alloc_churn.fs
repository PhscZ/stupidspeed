\ task 05 alloc_churn — expected output: 1274991808
\ build: none (gforth interprets the file)
\ run:   gforth 05_alloc_churn.fs        (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ Ten million 64-byte buffers, each freed by the next one that lands in the same slot of
\ the 256-entry ring. Forth has no garbage collector, so the drop is an explicit FREE, the
\ same shape the C row's free has: this cell measures the allocator, not a collector.
\ The ring lives in the dictionary, and gforth's dictionary is case-insensitive, so the
\ constant that sizes it must not be spelled the same as the ring itself: SLOT-COUNT, not
\ SLOTS, or CREATE would overwrite the constant and ALLOT would be handed the ring's own
\ address instead of 256.

variable total
variable i
variable buf
64 constant BUFSZ
256 constant SLOT-COUNT

create slots SLOT-COUNT cells allot

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  0 total !
  slots SLOT-COUNT cells 0 fill
  0 i !
  begin i @ 10000000 < while
    BUFSZ allocate throw buf !
    i @ 256 mod buf @ !
    buf @ @ total +!
    \ free the buffer this slot replaces, then keep the new one reachable
    i @ 256 mod cells slots + @ ?dup if free throw then
    buf @ i @ 256 mod cells slots + !
    1 i +!
  repeat
  \ release whatever is still held
  0 i !
  begin i @ SLOT-COUNT < while
    i @ cells slots + @ ?dup if free throw then
    1 i +!
  repeat
  ss-report
  total @ . cr
;

main
bye
