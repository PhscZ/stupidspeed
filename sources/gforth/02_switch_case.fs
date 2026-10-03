\ task 02 switch_case — expected output: 7500000075000000
\ build: none (gforth interprets the file)
\ run:   gforth 02_switch_case.fs        (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ gforth is a 64-bit Forth, so a single-cell accumulator holds the whole total: the answer
\ is 7.5e15, comfortably inside the 2^63 range of a cell. The four-way dispatch is a nested
\ if/else, which is how a switch is written in Forth.

variable acc
variable i

: main
  0 acc !
  0 i !
  begin
    i @ 100000000 <
  while
    i @ 4 mod
    dup 0= if drop  1 acc +!
    else dup 1 = if drop  i @ acc +!
    else dup 2 = if drop  i @ 2 * acc +!
    else drop  i @ 3 * acc +!
    then then then
    1 i +!
  repeat
  acc @ . cr
;

main
bye
