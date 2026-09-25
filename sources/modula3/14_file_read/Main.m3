(* task 14 file_read — expected output: 484442112 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: data.bin must be in the working directory: 409600 copies of the byte cycle 0..255 *)

MODULE Main;
IMPORT IO, Fmt, FS, File;

CONST chunk = 1048576;   (* 1 MiB *)

VAR buf: ARRAY [0..chunk - 1] OF File.Byte;
    f: File.T;
    got, i, total: INTEGER;

BEGIN
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

  IO.Put(Fmt.Int(total MOD 4294967296) & "\n");
END Main.
