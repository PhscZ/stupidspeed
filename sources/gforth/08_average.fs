\ task 08 average — expected output: 0.498046875
\ build: none (gforth interprets the file)
\ run:   gforth 08_average.fs            (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Floating point on a separate float stack. Every reading is an exact
\ multiple of 1/256 and the running total stays under 2^36, so the sum is exact in a double
\ and the digits do not depend on the order of addition.
\ This build of gforth carries only the floating-point primitives: the FLOATING wordset
\ itself is absent, so there are no float literals and no F. and no FCONSTANT. The
\ conversions are therefore written S>F (which the primitives do provide) and the print is
\ built on the standard REPRESENT, which hands back the rounded digit string, the decimal
\ exponent and the sign.

variable i

\ print a value in [0, 10) with nine fraction digits, the way F. would
: .fix9  ( r -- )
  pad 9 represent      ( n sign valid )
  0= if
    2drop ." 0.000000000" exit
  then
  swap >r              ( sign )
  if '-' emit then
  ." 0."
  r@ 0< if 0 r@ negate ?do '0' emit loop then
  pad 9 type
  r> drop
;

\ timing: utime is gforth's microsecond clock; TIME_MS is written to stderr with
\         WRITE-FILE/WRITE-LINE and stdout is unchanged.
2variable ss-t0

: ss-report ( -- )
  s" TIME_MS=" stderr write-file drop
  utime ss-t0 2@ d- drop 1000 /
  s>d <# #s #> stderr write-line drop ;

: main
  utime ss-t0 2!
  0 i !
  0 s>f
  begin
    i @ 100000000 <
  while
    i @ 256 mod s>f
    256 s>f f/ f+
    1 i +!
  repeat
  100000000 s>f f/
  ss-report
  .fix9 cr
;

main
bye
