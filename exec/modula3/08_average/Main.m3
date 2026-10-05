(* task 08 average — expected output: 0.498046875 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Time, FileWr, Wr;

VAR ssT0: Time.T;
    total, reading: LONGREAL;
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
  total := 0.0D0;
  FOR i := 0 TO 99999999 DO
    reading := FLOAT(i MOD 256, LONGREAL) / 256.0D0;
    total := total + reading
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.LongReal(total / 100000000.0D0, Fmt.Style.Fix, 9) & "\n");
END Main.
