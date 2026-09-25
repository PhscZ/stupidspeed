(* task 13 matrix_mul -- expected output: 599995000 *)
(* build: m2amd64.exe /sym:<symdir> 13_matrix_mul.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task13;
IMPORT STextIO, SLWholeIO;
CONST n = 500;
VAR
   a, b : ARRAY [0 .. n - 1] OF ARRAY [0 .. n - 1] OF CARDINAL;
   c    : ARRAY [0 .. n - 1] OF ARRAY [0 .. n - 1] OF LONGCARD;
   i, j, k : CARDINAL;
   sum  : LONGCARD;
   total : LONGCARD;
BEGIN
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         a [i][j] := (i + j) MOD 7;
         b [i][j] := (i * j) MOD 5
      END
   END;
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         sum := 0;
         FOR k := 0 TO n - 1 DO
            sum := sum + VAL (LONGCARD, a [i][k]) * VAL (LONGCARD, b [k][j])
         END;
         c [i][j] := sum
      END
   END;
   total := 0;
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         total := total + c [i][j]
      END
   END;
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task13.
