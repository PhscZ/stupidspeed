(* task 05 alloc_churn — expected output: 1274991808 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

TYPE Buf = REF ARRAY OF CHAR;

VAR slots: ARRAY [0..255] OF Buf;
    buf: Buf;
    i, total: INTEGER;

BEGIN
  FOR i := 0 TO 255 DO
    slots[i] := NIL
  END;

  total := 0;
  FOR i := 0 TO 9999999 DO
    buf := NEW(Buf, 64);
    buf[0] := VAL(i MOD 256, CHAR);
    total := total + ORD(buf[0]);
    (* keeping buf reachable stops the allocation being deleted, and the
       buffer it replaces becomes garbage for the collector *)
    slots[i MOD 256] := buf
  END;
  IO.Put(Fmt.Int(total) & "\n");
END Main.
