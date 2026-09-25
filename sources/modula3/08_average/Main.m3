(* task 08 average — expected output: 0.498046875 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

VAR total, reading: LONGREAL;
    i: INTEGER;

BEGIN
  total := 0.0D0;
  FOR i := 0 TO 99999999 DO
    reading := FLOAT(i MOD 256, LONGREAL) / 256.0D0;
    total := total + reading
  END;
  IO.Put(Fmt.LongReal(total / 100000000.0D0, Fmt.Style.Fix, 9) & "\n");
END Main.
