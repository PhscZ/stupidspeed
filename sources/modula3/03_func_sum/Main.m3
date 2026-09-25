(* task 03 func_sum — expected output: 100000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: the call crosses a module boundary, so it happens 100000000 times *)

MODULE Main;
IMPORT IO, Fmt, AddOne;

VAR value: INTEGER;
    i: INTEGER;

BEGIN
  value := 0;
  FOR i := 0 TO 99999999 DO
    value := AddOne.AddOne(value)
  END;
  IO.Put(Fmt.Int(value) & "\n");
END Main.
