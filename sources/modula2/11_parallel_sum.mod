(* task 11 parallel_sum -- expected output: 7500000075000000 *)
(* build: m2amd64.exe /sym:<symdir> 11_parallel_sum.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE TThread;

(* task 11 shape: 4 real OS threads, each doing a 64-bit sum, results combined *)

IMPORT STextIO, SLWholeIO, Threads;
FROM SYSTEM IMPORT ADDRESS, ADR, CAST;

CONST
   nThreads = 4;
   total    = 100000000;
   chunk    = total DIV nThreads;

TYPE
   Arg = RECORD
            lo, hi : LONGCARD;
            idx    : CARDINAL
         END;
   ArgPtr = POINTER TO Arg;

VAR
   threads : ARRAY [0 .. nThreads - 1] OF Threads.Thread;
   args    : ARRAY [0 .. nThreads - 1] OF Arg;
   part    : ARRAY [0 .. nThreads - 1] OF LONGCARD;
   k       : CARDINAL;
   acc     : LONGCARD;
   code    : CARDINAL;
   res     : Threads.WaitResult;

PROCEDURE Worker (p : ADDRESS) : CARDINAL;
VAR
   a   : ArgPtr;
   i   : LONGCARD;
   s   : LONGCARD;
BEGIN
   a := CAST (ArgPtr, p);
   s := 0;
   FOR i := a^.lo TO a^.hi DO
      CASE i MOD 4 OF
         0: s := s + 1
      |  1: s := s + i
      |  2: s := s + 2 * i
      |  3: s := s + 3 * i
      END
   END;
   part [a^.idx] := s;
   RETURN 0
END Worker;

BEGIN
   FOR k := 0 TO nThreads - 1 DO
      args [k].lo  := VAL (LONGCARD, k) * chunk;
      args [k].hi  := args [k].lo + chunk - 1;
      args [k].idx := k;
      part [k] := 0;
      IF NOT Threads.CreateThread (threads [k], Worker, ADR (args [k]), 0, TRUE) THEN
         STextIO.WriteString ("thread create failed");
         STextIO.WriteLn;
         HALT
      END
   END;
   FOR k := 0 TO nThreads - 1 DO
      res := Threads.WaitForThreadTermination (threads [k], Threads.SemWaitForever, code);
      IF res # Threads.WaitSuccess THEN
         STextIO.WriteString ("wait failed");
         STextIO.WriteLn;
         HALT
      END
   END;
   acc := 0;
   FOR k := 0 TO nThreads - 1 DO
      acc := acc + part [k]
   END;
   SLWholeIO.WriteLongCard (acc, 0);
   STextIO.WriteLn
END TThread.
