// task 07 string_append — expected output: 1000000
// build: cintsys64 -c bcpl 07_string_append.b to 07_string_append    run: cintsys64 -c 07_string_append
// note: 64-bit Cintcode system. Needs BCPL64ROOT/BCPL64PATH/BCPL64HDRS/BCPL64SCRIPTS set
//       (BCPL64PATH=$BCPL64ROOT/cin64, BCPL64HDRS=$BCPL64ROOT/g) and $BCPL64ROOT/bin on PATH,
//       where cintsys64 lives; build and run from this directory, since the compiled Cintcode
//       file is written to the working directory. Add -q to suppress the interpreter banner
//       and the CLI prompts.
// note: BCPL has no string concatenation operator, and a BCPL string holds its length in a
//       single byte at %0, so it cannot even represent a million-character string. As in the
//       Oberon-2 and Modula-2 rows, the appends therefore grow the text in place at the end
//       of a preallocated character buffer, and the length is then found by scanning for the
//       0 terminator.

SECTION "07_string_append"

GET "libhdr"

LET start() = VALOF
{ LET n = 1000000
  LET text = getvec(n)
  LET len = 0
  LET i = 0

  FOR i = 1 TO n DO
  { text%len := 'x'
    len := len + 1
  }
  text%len := 0

  // length of the string that was built, found by scanning for the 0 terminator
  len := 0
  WHILE text%len ~= 0 DO len := len + 1

  writef("%n*n", len)
  RESULTIS 0
}
