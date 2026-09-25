(* task 14 file_read — expected output: 484442112 *)
(* build: CFLAGS=-O2 voc 14_file_read.mod -m    run: ./FileRead *)
(* note: data.bin (100 MiB, the bytes 0..255 repeating) must be in the working directory. *)
(*       Files.ReadBytes reads a whole megabyte per call; Files.Old finds it in the CWD. *)

MODULE FileRead;
IMPORT Out, Files;

CONST
  Chunk = 1048576;
  Reps  = 100;

VAR
  f: Files.File;
  r: Files.Rider;
  buf: ARRAY Chunk OF CHAR;
  total: HUGEINT;
  i, j: LONGINT;

BEGIN
  f := Files.Old("data.bin");
  IF f = NIL THEN Out.String("cannot open data.bin"); Out.Ln; HALT(1) END;

  Files.Set(r, f, 0);
  total := 0;
  FOR i := 1 TO Reps DO
    Files.ReadBytes(r, buf, Chunk);
    FOR j := 0 TO Chunk - 1 DO
      total := total + ORD(buf[j])
    END
  END;
  Files.Close(f);

  total := total MOD 4294967296;
  Out.Int(total, 1); Out.Ln
END FileRead.
