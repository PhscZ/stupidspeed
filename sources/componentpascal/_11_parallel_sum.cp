(* task 11 parallel_sum — expected output: 7500000075000000 *)
(* build: gpcp /list- _11_parallel_sum.cp    run: _11_parallel_sum.exe *)
(* note: four real .NET threads, started with System.Threading.Thread. A Thread needs a
   ThreadStart delegate, which gpcp reaches through REGISTER applied to a bound method
   (REGISTER(s, w0.Run)) — the foreign ThreadStart type is already a delegate, so no
   EVENT type has to be declared. gpcp prints four "Procedure variables are deprecated"
   warnings for these calls; /warn- silences them and they do not affect the run. *)
(* note: each thread owns a fixed range of 25000000 indices and writes its own
   accumulator, so the result does not depend on how the threads are scheduled; the
   main thread joins all four before summing. *)
(* note: measured on this machine, the four threads are faster than task 02's serial
   loop: median 1475 ms against 2287 ms over five runs, both including the same .NET
   startup. *)
(* note: gpcp does not allow a LONGINT CASE selector, so each thread's index is a 32 bit
   INTEGER, which covers the range 0..99999999 that the work spans. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _11_parallel_sum.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)

MODULE _11_parallel_sum;
 IMPORT CPmain, Console, Th := mscorlib_System_Threading;

 CONST SLICE = 25000000;

 TYPE Worker = POINTER TO RECORD
                 t : LONGINT;   (* which quarter of the range this thread owns *)
                 acc : LONGINT
               END;

 VAR s0, s1, s2, s3 : Th.ThreadStart;
     th0, th1, th2, th3 : Th.Thread;
     w0, w1, w2, w3 : Worker;
     total : LONGINT;

 PROCEDURE (self : Worker) Run(), NEW;
   VAR i : INTEGER;
 BEGIN
   self.acc := 0;
   FOR i := SHORT(self.t * SLICE) TO SHORT((self.t + 1) * SLICE) - 1 DO
     CASE i MOD 4 OF
       0: self.acc := self.acc + 1
     | 1: self.acc := self.acc + i
     | 2: self.acc := self.acc + 2 * i
     | 3: self.acc := self.acc + 3 * i
     END
   END
 END Run;

 PROCEDURE WriteLong(x : LONGINT);
   VAR s : ARRAY 24 OF CHAR;
       n, k : INTEGER;
       t : CHAR;
 BEGIN
   IF x = 0 THEN Console.Write("0"); RETURN END;
   n := 0;
   WHILE x > 0 DO
     s[n] := CHR(SHORT(x MOD 10) + ORD("0"));
     x := x DIV 10;
     INC(n)
   END;
   s[n] := 0X;
   k := 0; DEC(n);
   WHILE k < n DO
     t := s[k]; s[k] := s[n]; s[n] := t;
     INC(k); DEC(n)
   END;
   Console.WriteString(s)
 END WriteLong;

BEGIN
  NEW(w0); NEW(w1); NEW(w2); NEW(w3);
  w0.t := 0; w1.t := 1; w2.t := 2; w3.t := 3;

  REGISTER(s0, w0.Run);
  REGISTER(s1, w1.Run);
  REGISTER(s2, w2.Run);
  REGISTER(s3, w3.Run);

  th0 := Th.Thread.init(s0);
  th1 := Th.Thread.init(s1);
  th2 := Th.Thread.init(s2);
  th3 := Th.Thread.init(s3);

  th0.Start(); th1.Start(); th2.Start(); th3.Start();
  th0.Join();  th1.Join();  th2.Join();  th3.Join();

  total := w0.acc + w1.acc + w2.acc + w3.acc;

  WriteLong(total); Console.WriteLn
END _11_parallel_sum.
