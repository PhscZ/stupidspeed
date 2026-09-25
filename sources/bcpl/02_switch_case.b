// task 02 switch_case — expected output: 7500000075000000
// build: cintsys64 -c bcpl 02_switch_case.b to 02_switch_case    run: cintsys64 -c 02_switch_case
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: the total is 7500000075000000, which needs more than 32 bits. BCPL's word size is
//       that of the Cintcode system it runs on, so this task is 64-bit only: under the
//       32-bit cintsys the accumulator wraps and the answer comes out wrong.

SECTION "02_switch_case"

GET "libhdr"

LET start() = VALOF
{ LET acc = 0
  LET i = 0

  FOR i = 0 TO 99999999 DO
  { SWITCHON i REM 4 INTO
    { CASE 0: acc := acc + 1; ENDCASE
      CASE 1: acc := acc + i; ENDCASE
      CASE 2: acc := acc + 2 * i; ENDCASE
      CASE 3: acc := acc + 3 * i; ENDCASE
    }
  }

  writef("%n*n", acc)
  RESULTIS 0
}
