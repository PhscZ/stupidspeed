(* task 06 char_count — expected output: 10000000 *)
(* timing: Time.Now is Modula-3's clock, seconds since the epoch as a REAL, so the
   elapsed time is exact to well under a millisecond; TIME_MS is written to time.txt
   with the FileWr/Wr idiom task 15 uses, because Modula-3's IO has no stderr stream,
   and stdout is unchanged. Verified on this machine with cm3 5.10.0: the compiled
   row prints the expected line and writes time.txt for all fifteen tasks. *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Text, Time, FileWr, Wr;

CONST pattern = ARRAY [0..9] OF CHAR{'a','b','c','d','e','f','g','h','i','j'};

VAR ssT0: Time.T;
    chars: ARRAY [0..99999999] OF CHAR;
    i, j, count: INTEGER;
    text: TEXT;


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
  (* the whole 100 MB text is built up front, block by block *)
  FOR i := 0 TO 9999999 DO
    FOR j := 0 TO 9 DO
      chars[i * 10 + j] := pattern[j]
    END
  END;
  text := Text.FromChars(chars);

  count := 0;
  FOR i := 0 TO Text.Length(text) - 1 DO
    CASE Text.GetChar(text, i) OF
      'a', 'e' => (* skip *)
    | 'h' => count := count + 1
    ELSE (* skip *)
    END
  END;
  SsReport(ROUND((Time.Now() - ssT0) * 1000.0D0));
  IO.Put(Fmt.Int(count) & "\n");
END Main.
