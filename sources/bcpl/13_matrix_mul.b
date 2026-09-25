// task 13 matrix_mul — expected output: 599995000
// build: cintsys64 -c bcpl 13_matrix_mul.b to 13_matrix_mul    run: cintsys64 -c 13_matrix_mul
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: plain i, j, k triple loop in that order, no reordering, no blocking. BCPL vectors
//       are flat, so both matrices are indexed by hand.

SECTION "13_matrix_mul"

GET "libhdr"

LET start() = VALOF
{ LET n = 500
  LET sz = n * n
  LET a = getvec(sz - 1)
  LET b = getvec(sz - 1)
  LET c = getvec(sz - 1)
  LET total = 0
  LET i, j, k = 0, 0, 0

  FOR i = 0 TO n - 1 DO
  { LET base = i * n
    FOR j = 0 TO n - 1 DO
    { a!(base + j) := (i + j) REM 7
      b!(base + j) := (i * j) REM 5
    }
  }

  FOR i = 0 TO n - 1 DO
  { LET ibase = i * n
    FOR j = 0 TO n - 1 DO
    { LET sum = 0
      FOR k = 0 TO n - 1 DO
        sum := sum + a!(ibase + k) * b!(k * n + j)
      c!(ibase + j) := sum
    }
  }

  FOR i = 0 TO n - 1 DO
  { LET base = i * n
    FOR j = 0 TO n - 1 DO total := total + c!(base + j)
  }

  writef("%n*n", total)
  RESULTIS 0
}
