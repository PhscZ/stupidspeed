// task 15 file_write — expected output: 104857600
// build: cintsys64 -c bcpl 15_file_write.b to 15_file_write    run: cintsys64 -c 15_file_write
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: findoutput/selectoutput/writewords are BCPL's stream library. endwrite closes the
//       stream, which flushes it to disk; BCPL has no separate fsync. endwrite leaves cos
//       zero, so the console stream is saved with output() and put back afterwards, or the
//       final writef has nowhere to go.
// note: out.bin is created in the working directory and needs 100 MiB of free space.

SECTION "15_file_write"

GET "libhdr"

LET start() = VALOF
{ LET chunk = 1048576
  LET nwords = chunk / bytesperword
  LET buf = getvec(nwords - 1)
  LET written = 0
  LET scb = 0
  LET save = 0
  LET i, k = 0, 0

  FOR i = 0 TO chunk - 1 DO buf%i := i REM 256

  save := output()
  scb := findoutput("out.bin")

  IF scb = 0 DO
  { writef("cannot create out.bin*n")
    RESULTIS 1
  }

  selectoutput(scb)

  FOR k = 1 TO 100 DO
  { IF writewords(buf, nwords) DO written := written + chunk
  }

  endwrite()
  selectoutput(save)

  writef("%n*n", written)
  RESULTIS 0
}
