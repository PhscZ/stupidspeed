(* task 05 alloc_churn — expected output: 1274991808 *)
(* build: CFLAGS=-O2 voc 05_alloc_churn.mod -m    run: ./AllocChurn *)
(* note: NEW allocates from voc's own mark and sweep heap; the slots array keeps *)
(*       the last 256 buffers reachable and drops the one it replaces, which is *)
(*       what turns the replaced buffers into garbage for the collector. *)

MODULE AllocChurn;
IMPORT Out;

TYPE
  Buf = POINTER TO ARRAY 64 OF CHAR;

VAR
  slots: ARRAY 256 OF Buf;
  buf: Buf;
  total: HUGEINT;
  i: LONGINT;

BEGIN
  total := 0;
  FOR i := 0 TO 9999999 DO
    NEW(buf);
    buf[0] := CHR(i MOD 256);
    total := total + ORD(buf[0]);
    slots[i MOD 256] := buf
  END;
  Out.Int(total, 1); Out.Ln
END AllocChurn.
