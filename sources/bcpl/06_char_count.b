// task 06 char_count — expected output: 10000000
// build: cintsys64 -m 20000000 -c bcpl 06_char_count.b to 06_char_count    run: cintsys64 -m 20000000 -c 06_char_count
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: -m 20000000 raises the Cintcode memory from its 8000000-word default; the 100 MB
//       text needs 12500000 words on a 64-bit Cintcode system.
// note: the whole text is built up front, block by block, never by appending in a loop.
//       A BCPL string has a one-byte length at %0, so a 100 MB text cannot be a BCPL string;
//       it is a byte vector, which is what a BCPL string is underneath.

SECTION "06_char_count"

GET "libhdr"

LET start() = VALOF
{ LET n = 100000000
  LET text = getvec(n / bytesperword - 1)
  LET blk = "abcdefghij"
  LET count = 0
  LET i = 0

  // build the whole text up front, one 10-byte block at a time
  FOR i = 0 TO n - 1 DO text%i := blk%(i REM 10 + 1)

  FOR i = 0 TO n - 1 DO
  { LET ch = text%i
    IF ch = 'h' DO count := count + 1
  }

  writef("%n*n", count)
  RESULTIS 0
}
