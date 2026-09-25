(* task 02 switch_case — expected output: 7500000075000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

VAR a: INTEGER;
    i: INTEGER;

BEGIN
  a := 0;
  FOR i := 0 TO 99999999 DO
    CASE i MOD 4 OF
      0 => a := a + 1
    | 1 => a := a + i
    | 2 => a := a + 2 * i
    | 3 => a := a + 3 * i
    END
  END;
  IO.Put(Fmt.Int(a) & "\n");
END Main.
