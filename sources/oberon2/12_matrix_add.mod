(* task 12 matrix_add — expected output: 999000000 *)
(* build: CFLAGS=-O2 voc 12_matrix_add.mod -m    run: ./MatrixAdd *)
(* note: three 4 MB arrays of LONGINT, filled and then summed in separate loops. *)

MODULE MatrixAdd;
IMPORT Out;

CONST
  N = 1000;

VAR
  a, b, c: ARRAY N, N OF LONGINT;
  total: HUGEINT;
  i, j: LONGINT;

BEGIN
  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      a[i, j] := i + j;
      b[i, j] := i - j
    END
  END;

  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      c[i, j] := a[i, j] + b[i, j]
    END
  END;

  total := 0;
  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      total := total + c[i, j]
    END
  END;

  Out.Int(total, 1); Out.Ln
END MatrixAdd.
