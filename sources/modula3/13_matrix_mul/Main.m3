(* task 13 matrix_mul — expected output: 599995000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

CONST n = 500;

VAR a, b, c: REF ARRAY OF INTEGER;
    i, j, k, sum, total: INTEGER;

BEGIN
  a := NEW(REF ARRAY OF INTEGER, n * n);
  b := NEW(REF ARRAY OF INTEGER, n * n);
  c := NEW(REF ARRAY OF INTEGER, n * n);

  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      a[i * n + j] := (i + j) MOD 7;
      b[i * n + j] := (i * j) MOD 5
    END
  END;

  (* plain i, j, k triple loop, in that order *)
  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      sum := 0;
      FOR k := 0 TO n - 1 DO
        sum := sum + a[i * n + k] * b[k * n + j]
      END;
      c[i * n + j] := sum
    END
  END;

  total := 0;
  FOR i := 0 TO n * n - 1 DO
    total := total + c[i]
  END;
  IO.Put(Fmt.Int(total) & "\n");
END Main.
