// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: cintsys64 -c bcpl 01_branches.b to 01_branches    run: cintsys64 -c 01_branches
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: BCPL has no IF/ELSE, so the if/else chain is a nest of TEST/THEN/ELSE.

SECTION "01_branches"

GET "libhdr"

LET start() = VALOF
{ LET a, b, c, d = 0, 0, 0, 0
  LET i = 0

  FOR i = 0 TO 99999999 DO
  { TEST i REM 3 = 0 THEN a := a + 1
    ELSE TEST i REM 5 = 0 THEN b := b + 1
    ELSE TEST i REM 7 = 0 THEN c := c + 1
    ELSE d := d + 1
  }

  writef("%n %n %n %n*n", a, b, c, d)
  RESULTIS 0
}
