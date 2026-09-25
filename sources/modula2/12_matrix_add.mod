(* task 12 matrix_add -- expected output: 999000000 *)
(* build: m2amd64.exe /sym:<symdir> 12_matrix_add.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task12;
IMPORT STextIO, SLWholeIO;
CONST n = 1000;
VAR
   a, b, c : ARRAY [0 .. n - 1] OF ARRAY [0 .. n - 1] OF CARDINAL;
   i, j : CARDINAL;
   total : LONGCARD;
BEGIN
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         a [i][j] := i + j;
         b [i][j] := i - j
      END
   END;
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         c [i][j] := a [i][j] + b [i][j]
      END
   END;
   total := 0;
   FOR i := 0 TO n - 1 DO
      FOR j := 0 TO n - 1 DO
         total := total + VAL (LONGCARD, c [i][j])
      END
   END;
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task12.
