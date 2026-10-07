(* task 03 func_sum -- expected output: 100000000 *)
(* timing: SysClock.GetClock is the ISO Modula-2 clock (local time of day, whole
   seconds plus SysClock.fractions); TIME_MS is written to time.txt in milliseconds
   with the same SeqFile/IOChan idiom task 15 uses, because ADW exposes no stderr
   handle, and stdout is unchanged. Verified on this machine with ADW 1.6.879: the
   compiled row prints the expected line and writes time.txt for all fifteen tasks. *)
(* build: m2amd64.exe /sym:.;<adw>\ASCII\winamd64sym Func.def, then Func.mod, then 03_func_sum.mod, *)
(*        then sblink.exe /machine:amd64 /out:prog.exe Task03.obj Func.obj <adw>\ASCII\rtl-win-amd64.lib <adw>\ASCII\win64api.lib *)
MODULE Task03;
FROM SYSTEM IMPORT ADR;
IMPORT STextIO, SLWholeIO, Func, SysClock, SeqFile, IOChan, ChanConsts;
VAR
   ssT0 : LONGCARD;
   i : CARDINAL;
   value : LONGCARD;

PROCEDURE SsNow () : LONGCARD;
   (* ISO SysClock: local date and time of day, whole seconds plus a fraction *)
   VAR dt : SysClock.DateTime;
BEGIN
   SysClock.GetClock (dt);
   RETURN (VAL (LONGCARD, dt.hour) * 3600 + VAL (LONGCARD, dt.minute) * 60
           + VAL (LONGCARD, dt.second)) * 1000
          + VAL (LONGCARD, dt.fractions) * 1000 DIV (VAL (LONGCARD, SysClock.maxSecondParts) + 1)
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
   value := 0;
   FOR i := 1 TO 100000000 DO
      value := Func.AddOne (value)
   END;
   SsReport (ssT0);
   SLWholeIO.WriteLongCard (value, 0); STextIO.WriteLn
END Task03.
