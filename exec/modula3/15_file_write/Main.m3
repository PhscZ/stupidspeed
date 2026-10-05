(* task 15 file_write — expected output: 52428800 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, FileWr, Wr, Time;

CONST chunk = 1048576;   (* 1 MiB *)
      reps  = 50;

VAR ssT0: Time.T;
    buf: ARRAY [0..chunk - 1] OF CHAR;
    wr: Wr.T;
    i, written: INTEGER;


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
  (* the 1 MiB buffer is bytes 0,1,2,...,255 repeated 4096 times *)
  FOR i := 0 TO chunk - 1 DO
    buf[i] := VAL(i MOD 256, CHAR)
  END;

  wr := FileWr.Open("out.bin");

  written := 0;
  FOR i := 1 TO reps DO
    Wr.PutString(wr, buf);
    written := written + chunk
  END;
  Wr.Flush(wr);
  Wr.Close(wr);

  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(written) & "\n");
END Main.
