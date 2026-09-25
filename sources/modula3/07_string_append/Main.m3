(* task 07 string_append — expected output: 1000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Text;

VAR t: TEXT;
    i: INTEGER;

BEGIN
  t := "";
  FOR i := 0 TO 999999 DO
    t := t & "x"
  END;
  IO.Put(Fmt.Int(Text.Length(t)) & "\n");
END Main.
