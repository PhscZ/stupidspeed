(* task 01 branches -- expected output: 33333334 13333333 7619048 45714285 *)
(* build: m2amd64.exe /sym:<symdir> 01_branches.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task01;

IMPORT STextIO, WholeStr;

VAR
   i: CARDINAL;
   a, b, c, d: CARDINAL;
   buf: ARRAY [0 .. 31] OF CHAR;

BEGIN
   a := 0; b := 0; c := 0; d := 0;
   FOR i := 0 TO 99999999 DO
      IF i MOD 3 = 0 THEN
         a := a + 1
      ELSIF i MOD 5 = 0 THEN
         b := b + 1
      ELSIF i MOD 7 = 0 THEN
         c := c + 1
      ELSE
         d := d + 1
      END
   END;
   WholeStr.CardToStr (a, buf); STextIO.WriteString (buf); STextIO.WriteString (" ");
   WholeStr.CardToStr (b, buf); STextIO.WriteString (buf); STextIO.WriteString (" ");
   WholeStr.CardToStr (c, buf); STextIO.WriteString (buf); STextIO.WriteString (" ");
   WholeStr.CardToStr (d, buf); STextIO.WriteString (buf); STextIO.WriteLn
END Task01.
