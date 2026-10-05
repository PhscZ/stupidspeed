(* task 14 file_read — expected output: 2389704704 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Verified on this machine with cm3 5.10.0: the compiled
   row prints the expected line and writes time.txt for all fifteen tasks. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: data.bin must be in the working directory: 204800 copies of the byte cycle 0..255 *)

MODULE Main;
IMPORT IO, Fmt, FS, File, Time, FileWr, Wr;

CONST chunk = 1048576;   (* 1 MiB *)

VAR ssT0: Time.T;
    buf: ARRAY [0..chunk - 1] OF File.Byte;
    f: File.T;
    got, i, total: INTEGER;


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
  f := FS.OpenFileReadonly("data.bin");

  total := 0;
  LOOP
    got := f.read(buf);
    IF got <= 0 THEN EXIT END;
    FOR i := 0 TO got - 1 DO
      total := total + buf[i]
    END
  END;
  f.close();

  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(total MOD 4294967296) & "\n");
END Main.
