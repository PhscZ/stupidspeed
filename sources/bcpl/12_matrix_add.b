// task 12 matrix_add — expected output: 999000000
// build: cintsys64 -c bcpl 12_matrix_add.b to 12_matrix_add    run: cintsys64 -c 12_matrix_add
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: BCPL vectors are flat, so a 1000x1000 matrix is one getvec of a million words with
//       the row index folded in by hand.

SECTION "12_matrix_add"

GET "libhdr"

LET start() = VALOF
{ LET n = 1000
  LET sz = n * n
  LET a = getvec(sz - 1)
  LET b = getvec(sz - 1)
  LET c = getvec(sz - 1)
  LET total = 0
  LET i, j = 0, 0

  FOR i = 0 TO n - 1 DO
  { LET base = i * n
    FOR j = 0 TO n - 1 DO
    { a!(base + j) := i + j
      b!(base + j) := i - j
    }
  }

  FOR i = 0 TO n - 1 DO
  { LET base = i * n
    FOR j = 0 TO n - 1 DO c!(base + j) := a!(base + j) + b!(base + j)
  }

  FOR i = 0 TO n - 1 DO
  { LET base = i * n
    FOR j = 0 TO n - 1 DO total := total + c!(base + j)
  }

  writef("%n*n", total)
  RESULTIS 0
}
