// task 09 fib_recursive — expected output: 102334155
// build: cintsys64 -c bcpl 09_fib_recursive.b to 09_fib_recursive    run: cintsys64 -c 09_fib_recursive
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: naive recursion, no memoisation. BCPL has no IF/ELSE, so the base case is an
//       IF ... DO RESULTIS.

SECTION "09_fib_recursive"

GET "libhdr"

LET fib(n) = VALOF
{ IF n < 2 DO RESULTIS n
  RESULTIS fib(n - 1) + fib(n - 2)
}

LET start() = VALOF
{ writef("%n*n", fib(40))
  RESULTIS 0
}
