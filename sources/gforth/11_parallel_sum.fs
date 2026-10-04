\ task 11 parallel_sum — expected output: 7500000075000000
\ build: none (gforth interprets the file)
\ run:   gforth 11_parallel_sum.fs       (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. gforth has no threads on Windows: cilk.fs needs unix/pthread.fs, which is
\ Unix-only, and this image carries no thread wordset at all. The four workers are
\ therefore four child gforth processes, the same shape the VBScript and COBOL rows use.
\
\ The parent starts each child with the OS START command, which returns at once, so the
\ four really do run at the same time; if it used a blocking call they would only take
\ turns. Each child computes its quarter (i in t*25000000 .. (t+1)*25000000-1, the same
\ four-way dispatch as task 02) and writes its partial to gf11-<t>.tmp as one 8-byte cell.
\ The parent then polls for the four files, reads them, sums them, deletes them and prints
\ the total. It waits for all four before summing.
\
\ GFORTH's SYSTEM word lives in stuff.fs, which this image does not load, so the command is
\ passed to the (system) primitive directly. Its argument is a shell command line, so the
\ child's command is built as a string: the interpreter path comes from ARG 0, the script
\ path from SOURCEFILENAME, and the paths are quoted in case either contains a space.

25000000 constant QUARTER
4 constant WORKERS

variable wfirst
variable wlast
variable ii
variable acc
variable total
variable tries

create sbuf 1024 allot
variable slen

: sreset ( -- ) 0 slen ! ;
: sapp ( c-addr u -- )
  dup >r  sbuf slen @ +  swap  move  r> slen +! ;
: sapp1 ( c -- ) sbuf slen @ + c!  1 slen +! ;
: quote ( -- ) 34 sapp1 ;

: system ( c-addr u -- ) (system) throw ;

\ ---- the quarter ---------------------------------------------------------

: partial ( t -- n )
  QUARTER * wfirst !
  wfirst @ QUARTER + wlast !
  wfirst @ ii !
  0 acc !
  begin ii @ wlast @ < while
    ii @ 4 mod
    dup 0= if drop 1
    else dup 1 = if drop ii @
    else dup 2 = if drop ii @ 2 *
    else drop ii @ 3 *
    then then then
    acc +!
    1 ii +!
  repeat
  acc @
;

\ ---- the scratch file ----------------------------------------------------

: part-name ( t -- c-addr u )
  sreset
  s" gf11-" sapp
  '0' + sapp1
  s" .tmp" sapp
  sbuf slen @
;

: rm-part ( t -- ) part-name delete-file drop ;

\ ---- the child -----------------------------------------------------------

: child ( t -- )
  dup part-name  w/o create-file throw   ( t fid )
  >r
  partial                                ( n )
  pad !                                  ( )
  pad 1 cells r@ write-file throw
  r> close-file throw
;

\ ---- the parent ----------------------------------------------------------

: spawn ( t -- )
  sreset
  s" start " sapp
  quote quote
  s"  /b " sapp
  quote 0 arg sapp quote
  s"  " sapp
  quote sourcefilename sapp quote
  s"  " sapp
  '0' + sapp1
  sbuf slen @ system
;

\ read the child's partial, or report that it is not there yet. Both paths return two
\ cells (n flag) so that GET-PART can drop either one; returning only the flag on the
\ not-ready path left GET-PART's loop without its worker index on the stack.
: try-read ( t -- n flag )
  part-name r/o open-file               ( fid ior )
  0<> if
    drop 0 false exit
  then
  >r
  pad 1 cells r@ read-file throw        ( u2 )
  r> close-file throw
  8 = if pad @ true else 0 false then
;

: get-part ( t -- n )
  0 tries !
  begin
    dup try-read
    if
      nip exit
    then
    drop
    10 ms
    tries @ 1+ tries !
    tries @ 6000 > abort" task 11: a worker did not finish"
  again
;

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged. The counter brackets the four
\         spawns and the four joins.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  argc @ 1 > if
    1 arg drop c@ '0' - child
  else
    0 total !
    WORKERS 0 do i rm-part loop
    WORKERS 0 do i spawn loop
    WORKERS 0 do
      i get-part total +!
      i rm-part
    loop
    ss-report
    total @ . cr
  then
;

main
bye
