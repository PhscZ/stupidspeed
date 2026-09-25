(* task 02 switch_case — expected output: 7500000075000000 *)
(* build: CFLAGS=-O2 voc 02_switch_case.mod -m    run: ./SwitchCase *)
(* note: -O2 mode gives a 32 bit LONGINT, so the accumulator is HUGEINT, voc's *)
(*       predefined 64 bit integer type. The total needs more than 32 bits. *)

MODULE SwitchCase;
IMPORT Out;

VAR
  acc: HUGEINT;
  i: LONGINT;

BEGIN
  acc := 0;
  FOR i := 0 TO 99999999 DO
    CASE i MOD 4 OF
       0: INC(acc, 1)
    |  1: acc := acc + i
    |  2: acc := acc + 2 * i
    |  3: acc := acc + 3 * i
    ELSE
    END
  END;
  Out.Int(acc, 1); Out.Ln
END SwitchCase.
