(* task 11 parallel_sum — expected output: 7500000075000000 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Thread, Time, FileWr, Wr;

CONST N = 25000000;

VAR ssT0: Time.T;
    acc: ARRAY [0..3] OF INTEGER;

TYPE Job = Thread.Closure OBJECT
             t: INTEGER;
             OVERRIDES
               apply := Run;
           END;

PROCEDURE Run(self: Job): REFANY =
  VAR a: INTEGER; i: INTEGER;
  BEGIN
    a := 0;
    FOR i := self.t * N TO (self.t + 1) * N - 1 DO
      CASE i MOD 4 OF
        0 => a := a + 1
      | 1 => a := a + i
      | 2 => a := a + 2 * i
      | 3 => a := a + 3 * i
      END
    END;
    acc[self.t] := a;
    RETURN NIL
  END Run;

VAR j: Job;
    th: ARRAY [0..3] OF Thread.T;
    i: INTEGER;


PROCEDURE SsReport(ms: INTEGER) =
  (* one TIME_MS line in time.txt: Modula-3's IO has no stderr stream, so the contract's
     fallback applies; the file is written with the same FileWr/Wr idiom task 15 uses *)
  VAR wr: Wr.T;
  BEGIN
    wr := FileWr.Open("time.txt");
    Wr.PutText(wr, "TIME_MS=" & Fmt.Int(ms) & "\n");
    Wr.Flush(wr);
    Wr.Close(wr);
  END SsReport;

BEGIN
  ssT0 := Time.Now();
  FOR i := 0 TO 3 DO
    j := NEW(Job);
    j.t := i;
    th[i] := Thread.Fork(j)
  END;
  FOR i := 0 TO 3 DO
    EVAL Thread.Join(th[i])
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(acc[0] + acc[1] + acc[2] + acc[3]) & "\n");
END Main.
