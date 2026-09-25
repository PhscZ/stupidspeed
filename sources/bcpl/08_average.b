// task 08 average — expected output: 0.498046875
// build: cintsys64 -c bcpl 08_average.b to 08_average    run: cintsys64 -c 08_average
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: BCPL's writef %n.mf always emits a sign character, so %9.9f would print the answer
//       as " 0.498046875" with a leading space. The fixed-point digits are therefore taken
//       out of the double with fl_fix and written with %Z9, which zero-pads to 9 digits.
// note: fl_fix/fl_unmk are the sys(Sys_flt, ...) floating point operations of libhdr; BCPL
//       has no floating point operators of its own.

SECTION "08_average"

GET "libhdr"

LET start() = VALOF
{ LET FLT total = 0.0
  LET FLT x = 0.0
  LET ip, fr = 0, 0
  LET i = 0

  FOR i = 0 TO 99999999 DO
  { LET FLT reading = FLOAT(i REM 256) / 256.0
    total := total + reading
  }

  x := total / 100000000.0

  // the integer part, and the first nine digits after the decimal point
  ip := sys(Sys_flt, fl_fix, x)
  fr := sys(Sys_flt, fl_fix, (x - FLOAT ip) * 1000000000.0)

  writef("%n.%Z9*n", ip, fr)
  RESULTIS 0
}
