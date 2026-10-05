(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Time, FileWr, Wr;

VAR ssT0: Time.T;
    a, b, c, d: INTEGER;
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
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(a) & " " & Fmt.Int(b) & " " & Fmt.Int(c) & " " & Fmt.Int(d) & "\n");
END Main.
