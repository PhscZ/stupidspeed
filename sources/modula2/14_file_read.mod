(* task 14 file_read -- expected output: 484442112 *)
(* build: m2amd64.exe /sym:<symdir> 14_file_read.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task14;
IMPORT STextIO, SLWholeIO, SeqFile, IOChan, ChanConsts;
FROM SYSTEM IMPORT ADR;

CONST
   chunk = 1048576;
   reps  = 100;

VAR
   buf   : ARRAY [0 .. chunk - 1] OF CHAR;
   cid   : IOChan.ChanId;
   res   : ChanConsts.OpenResults;
   rd    : CARDINAL;
   i, j  : CARDINAL;
   total : LONGCARD;

BEGIN
   SeqFile.OpenRead (cid, "data.bin", SeqFile.raw, res);
   IF res # ChanConsts.opened THEN
      STextIO.WriteString ("open failed"); STextIO.WriteLn; HALT
   END;
   total := 0;
   FOR i := 1 TO reps DO
      IOChan.RawRead (cid, ADR (buf), chunk, rd);
      IF rd = 0 THEN HALT END;
      FOR j := 0 TO rd - 1 DO
         total := total + VAL (LONGCARD, ORD (buf [j]))
      END
   END;
   SeqFile.Close (cid);
   total := total MOD 4294967296;
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task14.
