(* task 13 matrix_mul — expected output: 599995000 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Instrumented by inspection: cm3 is not installed on this
   machine, so this row's timing is unverified. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Time, FileWr, Wr;

CONST n = 500;

VAR ssT0: Time.T;
    a, b, c: REF ARRAY OF INTEGER;
    i, j, k, sum, total: INTEGER;


PROCEDURE SsReport(ms: INTEGER) =
  (* one TIME_MS line in time.txt: Modula-3's IO has no stderr stream, so the contract's
     fallback applies; the file is written with the same FileWr/Wr idiom task 15 uses *)
  VAR wr: Wr.T;
  BEGIN
    wr := FileWr.Open("time.txt");
    Wr.PutString(wr, "TIME_MS=" & Fmt.Int(ms) & "\n");
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
      a[i * n + j] := (i + j) MOD 7;
      b[i * n + j] := (i * j) MOD 5
    END
  END;

  (* plain i, j, k triple loop, in that order *)
  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO
      sum := 0;
      FOR k := 0 TO n - 1 DO
        sum := sum + a[i * n + k] * b[k * n + j]
      END;
      c[i * n + j] := sum
    END
  END;

  total := 0;
  FOR i := 0 TO n * n - 1 DO
    total := total + c[i]
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0));
  IO.Put(Fmt.Int(total) & "\n");
END Main.
