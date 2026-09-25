(* task 07 string_append — expected output: 1000000 *)
(* build: CFLAGS=-O2 voc 07_string_append.mod -m    run: ./StringAppend *)
(* note: Oberon's string type is ARRAY OF CHAR, a fixed length array with a 0X *)
(*       terminator, and the language has no string concatenation operator. The *)
(*       appends therefore grow the string in place at the end of the buffer, *)
(*       the same way the Modula-2 row of this benchmark does it. *)

MODULE StringAppend;
IMPORT Out;

VAR
  text: ARRAY 1000001 OF CHAR;
  len: LONGINT;
  i: LONGINT;

BEGIN
  len := 0;
  FOR i := 1 TO 1000000 DO
    text[len] := "x";
    INC(len)
  END;
  text[len] := 0X;

  (* length of the string that was built, found by scanning for the 0X terminator *)
  len := 0;
  WHILE text[len] # 0X DO INC(len) END;

  Out.Int(len, 1); Out.Ln
END StringAppend.
