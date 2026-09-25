// task 03 func_sum — expected output: 100000000
// build: cintsys64 -c bcpl 03_func_sum.b to 03_func_sum    run: cintsys64 -c 03_func_sum
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: add_one lives in its own file, 03_func_sum_add_one.b, as the task asks; the bcpl
//       command takes one source file, so the second is pulled in with GET, which is how the
//       distribution's own multi-file programs (com/bcpl.b and friends) are built. BCPL has
//       no inliner, so the call happens a hundred million times whatever the compiler does.

SECTION "03_func_sum"

GET "libhdr"
GET "03_func_sum_add_one.b"

LET start() = VALOF
{ LET value = 0
  LET i = 0

  FOR i = 1 TO 100000000 DO value := add_one(value)

  writef("%n*n", value)
  RESULTIS 0
}
