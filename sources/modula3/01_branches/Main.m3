(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

VAR a, b, c, d: INTEGER;
    i: INTEGER;

BEGIN
  a := 0; b := 0; c := 0; d := 0;
  FOR i := 0 TO 99999999 DO
    IF i MOD 3 = 0 THEN
      a := a + 1
    ELSIF i MOD 5 = 0 THEN
      b := b + 1
    ELSIF i MOD 7 = 0 THEN
      c := c + 1
    ELSE
      d := d + 1
    END
  END;
  IO.Put(Fmt.Int(a) & " " & Fmt.Int(b) & " " & Fmt.Int(c) & " " & Fmt.Int(d) & "\n");
END Main.
