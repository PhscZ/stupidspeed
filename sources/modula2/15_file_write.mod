(* task 15 file_write -- expected output: 104857600 *)
(* build: m2amd64.exe /sym:<symdir> 15_file_write.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task15;
IMPORT STextIO, SLWholeIO, SeqFile, IOChan, ChanConsts;
FROM SYSTEM IMPORT ADR;

CONST
   chunk = 1048576;
   reps  = 100;

VAR
   buf   : ARRAY [0 .. chunk - 1] OF CHAR;
   cid   : IOChan.ChanId;
   res   : ChanConsts.OpenResults;
   i     : CARDINAL;
   total : LONGCARD;

BEGIN
   FOR i := 0 TO chunk - 1 DO buf [i] := CHR (i MOD 256) END;
   SeqFile.OpenWrite (cid, "out.bin", SeqFile.raw, res);
   IF res # ChanConsts.opened THEN
      STextIO.WriteString ("open failed"); STextIO.WriteLn; HALT
   END;
   total := 0;
   FOR i := 1 TO reps DO
      IOChan.RawWrite (cid, ADR (buf), chunk);
      total := total + VAL (LONGCARD, chunk)
   END;
   IOChan.Flush (cid);
   SeqFile.Close (cid);
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task15.
