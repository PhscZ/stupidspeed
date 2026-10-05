(* task 05 alloc_churn — expected output: 1274991808 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Time, FileWr, Wr;

TYPE Buf = REF ARRAY OF CHAR;

VAR ssT0: Time.T;
    slots: ARRAY [0..255] OF Buf;
    buf: Buf;
    i, total: INTEGER;


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
  FOR i := 0 TO 255 DO
    slots[i] := NIL
  END;

  total := 0;
  FOR i := 0 TO 9999999 DO
    buf := NEW(Buf, 64);
    buf[0] := VAL(i MOD 256, CHAR);
    total := total + ORD(buf[0]);
    (* keeping buf reachable stops the allocation being deleted, and the
       buffer it replaces becomes garbage for the collector *)
    slots[i MOD 256] := buf
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(total) & "\n");
END Main.
