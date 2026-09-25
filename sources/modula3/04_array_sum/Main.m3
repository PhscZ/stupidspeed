(* task 04 array_sum — expected output: 499999500000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

CONST n = 1000000;

VAR array: REF ARRAY OF INTEGER;
    i, total: INTEGER;

BEGIN
  array := NEW(REF ARRAY OF INTEGER, n);
  FOR i := 0 TO n - 1 DO
    array[i] := i
  END;

  total := 0;
  FOR i := 0 TO n - 1 DO
    total := total + array[i]
  END;
  IO.Put(Fmt.Int(total) & "\n");
END Main.
