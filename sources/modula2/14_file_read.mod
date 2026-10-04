(* task 14 file_read -- expected output: 2389704704 *)
(* timing: SysClock.GetClock is the ISO Modula-2 clock (local time of day, whole
   seconds plus SysClock.fractions); TIME_MS is written to time.txt in milliseconds
   with the same SeqFile/IOChan idiom task 15 uses, because ADW exposes no stderr
   handle, and stdout is unchanged. Instrumented by inspection: the ADW toolchain is
   not installed on this machine, so this row's timing is unverified, and the
   SysClock module name is the one thing here that has not been compiled. *)
(* build: m2amd64.exe /sym:<symdir> 14_file_read.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task14;
IMPORT STextIO, SLWholeIO, SeqFile, IOChan, ChanConsts, SysClock;
FROM SYSTEM IMPORT ADR;

CONST
   chunk = 1048576;
   reps  = 50;

VAR
   ssT0 : LONGCARD;
   buf   : ARRAY [0 .. chunk - 1] OF CHAR;
   cid   : IOChan.ChanId;
   res   : ChanConsts.OpenResults;
   rd    : CARDINAL;
   i, j  : CARDINAL;
   total : LONGCARD;

PROCEDURE SsNow () : LONGCARD;
   (* ISO SysClock: local date and time of day, whole seconds plus a fraction *)
   VAR dt : SysClock.DateTime;
BEGIN
   SysClock.GetClock (dt);
   RETURN (LONGCARD (dt.hour) * 3600 + LONGCARD (dt.minute) * 60
           + LONGCARD (dt.second)) * 1000
          + LONGCARD (dt.fractions) * 1000 DIV (LONGCARD (SysClock.maxSecondParts) + 1)
END SsNow;

PROCEDURE SsReport (t0 : LONGCARD);
   (* one TIME_MS line in time.txt: ADW exposes no stderr handle, so the contract's
      fallback applies; the file is written with the same SeqFile/IOChan idiom as task 15 *)
   VAR cid : IOChan.ChanId;
       res : ChanConsts.OpenResults;
       buf : ARRAY [0 .. 31] OF CHAR;
       d   : ARRAY [0 .. 23] OF CHAR;
       ms  : LONGCARD;
       n, k : CARDINAL;
BEGIN
   ms := SsNow () - t0;
   buf [0] := 'T'; buf [1] := 'I'; buf [2] := 'M'; buf [3] := 'E';
   buf [4] := '_'; buf [5] := 'M'; buf [6] := 'S'; buf [7] := '=';
   n := 0;
   IF ms = 0 THEN
      d [0] := '0'; n := 1
   ELSE
      WHILE ms > 0 DO
         d [n] := CHR (VAL (CARDINAL, ms MOD 10) + ORD ('0'));
         ms := ms DIV 10;
         n := n + 1
      END
   END;
   k := 0;
   WHILE k < n DO
      buf [8 + k] := d [n - 1 - k];
      k := k + 1
   END;
   buf [8 + n] := CHR (10);
   SeqFile.OpenWrite (cid, "time.txt", SeqFile.raw, res);
   IF res = ChanConsts.opened THEN
      IOChan.RawWrite (cid, ADR (buf), 9 + n);
      IOChan.Flush (cid);
      SeqFile.Close (cid)
   END
END SsReport;


BEGIN
   ssT0 := SsNow ();
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
   SsReport (ssT0);
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task14.
