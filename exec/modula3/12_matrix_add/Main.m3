(* task 12 matrix_add — expected output: 999000000 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Time, FileWr, Wr;

CONST n = 1000;

VAR ssT0: Time.T;
    a, b, c: REF ARRAY OF INTEGER;
    i, j, total: INTEGER;


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
  a := NEW(REF ARRAY OF INTEGER, n * n);
  b := NEW(REF ARRAY OF INTEGER, n * n);
  c := NEW(REF ARRAY OF INTEGER, n * n);

  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      a[i * n + j] := i + j;
      b[i * n + j] := i - j
    END
  END;

  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      c[i * n + j] := a[i * n + j] + b[i * n + j]
    END
  END;

  total := 0;
  FOR i := 0 TO n * n - 1 DO
    total := total + c[i]
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(total) & "\n");
END Main.
