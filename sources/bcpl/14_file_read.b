// task 14 file_read — expected output: 484442112
// build: cintsys64 -c bcpl 14_file_read.b to 14_file_read    run: cintsys64 -c 14_file_read
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: data.bin (104857600 bytes, the bytes 0..255 repeating) must be in the working
//       directory. findinput/selectinput/readwords are BCPL's stream library; the buffer is
//       read one 1 MiB block at a time and then walked one byte at a time, as the task says.
// note: the byte total is 13369344000, so the 64-bit system is used; modulo 2^32 is what the
//       task prints, and that is also what the 32-bit system's wrapping arithmetic produces.

SECTION "14_file_read"

GET "libhdr"

LET start() = VALOF
{ LET chunk = 1048576
  LET nwords = chunk / bytesperword
  LET buf = getvec(nwords - 1)
  LET total = 0
  LET scb = findinput("data.bin")

  IF scb = 0 DO
  { writef("cannot open data.bin*n")
    RESULTIS 1
  }

  selectinput(scb)

  { LET got = readwords(buf, nwords)
    LET i = 0
    IF got = 0 DO BREAK
    FOR i = 0 TO got * bytesperword - 1 DO total := total + buf%i
  } REPEAT

  endread()

  writef("%n*n", total REM 4294967296)
  RESULTIS 0
}
