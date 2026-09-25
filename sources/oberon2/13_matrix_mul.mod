(* task 13 matrix_mul — expected output: 599995000 *)
(* build: CFLAGS=-O2 voc 13_matrix_mul.mod -m    run: ./MatrixMul *)
(* note: plain i, j, k triple loop in the order the task gives, no blocking or *)
(*       loop reordering. *)

MODULE MatrixMul;
IMPORT Out;

CONST
  N = 500;

VAR
  a, b, c: ARRAY N, N OF LONGINT;
  total, sum: HUGEINT;
  i, j, k: LONGINT;

BEGIN
  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      a[i, j] := (i + j) MOD 7;
      b[i, j] := (i * j) MOD 5
    END
  END;

  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      sum := 0;
      FOR k := 0 TO N - 1 DO
        sum := sum + a[i, k] * b[k, j]
      END;
      c[i, j] := SHORT(sum)
    END
  END;

  total := 0;
  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      total := total + c[i, j]
    END
  END;

  Out.Int(total, 1); Out.Ln
END MatrixMul.
