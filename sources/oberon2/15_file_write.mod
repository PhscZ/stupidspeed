(* task 15 file_write — expected output: 104857600 *)
(* build: CFLAGS=-O2 voc 15_file_write.mod -m    run: ./FileWrite *)
(* note: the 1 MiB buffer is written 100 times. Files.Register flushes every buffer *)
(*       to the operating system and renames the working file to out.bin, which is *)
(*       the strongest durability step the Oakwood file interface offers; it has no *)
(*       fsync. The printed number is the byte count handed to Files.WriteBytes. *)

MODULE FileWrite;
IMPORT Out, Files;

CONST
  Chunk = 1048576;
  Reps  = 100;

VAR
  f: Files.File;
  w: Files.Rider;
  buf: ARRAY Chunk OF CHAR;
  total: HUGEINT;
  i: LONGINT;

BEGIN
  FOR i := 0 TO Chunk - 1 DO
    buf[i] := CHR(i MOD 256)
  END;

  f := Files.New("out.bin");
  Files.Set(w, f, 0);
  total := 0;
  FOR i := 1 TO Reps DO
    Files.WriteBytes(w, buf, Chunk);
    total := total + Chunk
  END;
  Files.Register(f);

  Out.Int(total, 1); Out.Ln
END FileWrite.
