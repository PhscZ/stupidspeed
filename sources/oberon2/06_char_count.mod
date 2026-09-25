(* task 06 char_count — expected output: 10000000 *)
(* build: CFLAGS=-O2 voc 06_char_count.mod -m    run: ./CharCount *)
(* note: the whole 100 MB text is built up front by moving the ten character block *)
(*       into every tenth slot; nothing is appended in a loop. The scan then walks *)
(*       the array one character at a time. *)

MODULE CharCount;
IMPORT Out, SYSTEM;

CONST
  BlockLen = 10;
  Repeats  = 10000000;
  TextLen  = Repeats * BlockLen;

VAR
  text: ARRAY TextLen OF CHAR;
  pat: ARRAY BlockLen OF CHAR;
  count: HUGEINT;
  i: LONGINT;

BEGIN
  pat[0] := "a"; pat[1] := "b"; pat[2] := "c"; pat[3] := "d"; pat[4] := "e";
  pat[5] := "f"; pat[6] := "g"; pat[7] := "h"; pat[8] := "i"; pat[9] := "j";

  FOR i := 0 TO Repeats - 1 DO
    SYSTEM.MOVE(SYSTEM.ADR(pat), SYSTEM.ADR(text[i * BlockLen]), BlockLen)
  END;

  count := 0;
  FOR i := 0 TO TextLen - 1 DO
    IF text[i] = "a" THEN
      (* skip *)
    ELSIF text[i] = "e" THEN
      (* skip *)
    ELSIF text[i] = "h" THEN
      INC(count)
    ELSE
      (* skip *)
    END
  END;

  Out.Int(count, 1); Out.Ln
END CharCount.
