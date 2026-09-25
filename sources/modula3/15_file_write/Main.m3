(* task 15 file_write — expected output: 104857600 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, FileWr, Wr;

CONST chunk = 1048576;   (* 1 MiB *)
      reps  = 100;

VAR buf: ARRAY [0..chunk - 1] OF CHAR;
    wr: Wr.T;
    i, written: INTEGER;

BEGIN
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

  IO.Put(Fmt.Int(written) & "\n");
END Main.
