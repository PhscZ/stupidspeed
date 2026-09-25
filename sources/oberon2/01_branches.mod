(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* build: CFLAGS=-O2 voc 01_branches.mod -m    run: ./Branches *)
(* note: voc's C backend takes its optimisation flags from the CFLAGS environment variable. *)

MODULE Branches;
IMPORT Out;

VAR
  a, b, c, d: LONGINT;
  i: LONGINT;

BEGIN
  a := 0; b := 0; c := 0; d := 0;
  FOR i := 0 TO 99999999 DO
    IF i MOD 3 = 0 THEN
      INC(a)
    ELSIF i MOD 5 = 0 THEN
      INC(b)
    ELSIF i MOD 7 = 0 THEN
      INC(c)
    ELSE
      INC(d)
    END
  END;
  Out.Int(a, 1); Out.Char(" ");
  Out.Int(b, 1); Out.Char(" ");
  Out.Int(c, 1); Out.Char(" ");
  Out.Int(d, 1); Out.Ln
END Branches.
