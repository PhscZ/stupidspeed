// task 04 array_sum — expected output: 499999500000
// build: cintsys64 -c bcpl 04_array_sum.b to 04_array_sum    run: cintsys64 -c 04_array_sum
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: the total is 499999500000, which needs more than 32 bits, so this task is 64-bit
//       only: under the 32-bit cintsys the total wraps.
// note: getvec(n) is BCPL's allocator; the vector is indexed with ! for words.

SECTION "04_array_sum"

GET "libhdr"

LET start() = VALOF
{ LET n = 1000000
  LET v = getvec(n - 1)
  LET total = 0
  LET i = 0

  FOR i = 0 TO n - 1 DO v!i := i

  FOR i = 0 TO n - 1 DO total := total + v!i

  writef("%n*n", total)
  RESULTIS 0
}
