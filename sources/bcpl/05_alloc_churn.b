// task 05 alloc_churn — expected output: 1274991808
// build: cintsys64 -c bcpl 05_alloc_churn.b to 05_alloc_churn    run: cintsys64 -c 05_alloc_churn
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: getvec/freevec are BCPL's allocator, served from the Cintcode heap, so this churns
//       the heap the same way the C row churns malloc. 64/bytesperword words is 64 bytes.
// note: the store into slots keeps the buffer reachable and frees the buffer it replaces,
//       exactly as the task describes.

SECTION "05_alloc_churn"

GET "libhdr"

LET start() = VALOF
{ LET slots = getvec(255)
  LET total = 0
  LET i = 0

  FOR i = 0 TO 255 DO slots!i := 0

  FOR i = 0 TO 9999999 DO
  { LET k = i REM 256
    LET buf = getvec(64 / bytesperword - 1)
    LET old = slots!k
    buf%0 := k
    total := total + buf%0
    IF old DO freevec(old)
    slots!k := buf
  }

  writef("%n*n", total)
  RESULTIS 0
}
