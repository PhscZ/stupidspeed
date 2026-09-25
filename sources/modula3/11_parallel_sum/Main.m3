(* task 11 parallel_sum — expected output: 7500000075000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt, Thread;

CONST N = 25000000;

VAR acc: ARRAY [0..3] OF INTEGER;

TYPE Job = Thread.Closure OBJECT
             t: INTEGER;
             OVERRIDES
               apply := Run;
           END;

PROCEDURE Run(self: Job): REFANY =
  VAR a: INTEGER; i: INTEGER;
  BEGIN
    a := 0;
    FOR i := self.t * N TO (self.t + 1) * N - 1 DO
      CASE i MOD 4 OF
        0 => a := a + 1
      | 1 => a := a + i
      | 2 => a := a + 2 * i
      | 3 => a := a + 3 * i
      END
    END;
    acc[self.t] := a;
    RETURN NIL
  END Run;

VAR j: Job;
    th: ARRAY [0..3] OF Thread.T;
    i: INTEGER;

BEGIN
  FOR i := 0 TO 3 DO
    j := NEW(Job);
    j.t := i;
    th[i] := Thread.Fork(j)
  END;
  FOR i := 0 TO 3 DO
    EVAL Thread.Join(th[i])
  END;
  IO.Put(Fmt.Int(acc[0] + acc[1] + acc[2] + acc[3]) & "\n");
END Main.
