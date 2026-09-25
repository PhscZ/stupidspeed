(* task 12 matrix_add — expected output: 999000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

CONST n = 1000;

VAR a, b, c: REF ARRAY OF INTEGER;
    i, j, total: INTEGER;

BEGIN
  a := NEW(REF ARRAY OF INTEGER, n * n);
  b := NEW(REF ARRAY OF INTEGER, n * n);
  c := NEW(REF ARRAY OF INTEGER, n * n);

  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      a[i * n + j] := i + j;
      b[i * n + j] := i - j
    END
  END;

  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      c[i * n + j] := a[i * n + j] + b[i * n + j]
    END
  END;

  total := 0;
  FOR i := 0 TO n * n - 1 DO
    total := total + c[i]
  END;
  IO.Put(Fmt.Int(total) & "\n");
END Main.
