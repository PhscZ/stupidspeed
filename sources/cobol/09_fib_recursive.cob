      *> task 09 fib_recursive -- expected output: 102334155
      *> build: cobc -x -O2 -o prog 09_fib_recursive.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Built and run against GnuCOBOL 3.2 on this machine, so the timing is real.
      *>         The two COMPUTE CS0/CS1 lines were past column 72 and are wrapped.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T09.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 N        PIC 9(9)  COMP-5.
       01 R        PIC 9(18) COMP-5.
       01 ORR      PIC 9(9).
       01 WS-T0.
           05 T0-HH PIC 9(2).
           05 T0-MM PIC 9(2).
           05 T0-SS PIC 9(2).
           05 T0-CC PIC 9(2).
       01 WS-T1.
           05 T1-HH PIC 9(2).
           05 T1-MM PIC 9(2).
           05 T1-SS PIC 9(2).
           05 T1-CC PIC 9(2).
       01 CS0      PIC 9(18) COMP-5.
       01 CS1      PIC 9(18) COMP-5.
       01 MS       PIC 9(18) COMP-5.
       PROCEDURE DIVISION.
           ACCEPT WS-T0 FROM TIME.
           MOVE 40 TO N.
           CALL 'FIB' USING N R.
           MOVE R TO ORR.
           ACCEPT WS-T1 FROM TIME.
           COMPUTE CS0 = ((((T0-HH * 60) + T0-MM) * 60) + T0-SS)
               * 100 + T0-CC.
           COMPUTE CS1 = ((((T1-HH * 60) + T1-MM) * 60) + T1-SS)
               * 100 + T1-CC.
           IF CS1 < CS0
               ADD 8640000 TO CS1
           END-IF.
           COMPUTE MS = (CS1 - CS0) * 10.
           DISPLAY "TIME_MS=" MS UPON STDERR.
           DISPLAY ORR.
           STOP RUN.
       END PROGRAM T09.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIB IS RECURSIVE.
       DATA DIVISION.
       LOCAL-STORAGE SECTION.
       01 A        PIC 9(18) COMP-5.
       01 B        PIC 9(18) COMP-5.
       01 M        PIC 9(9)  COMP-5.
       LINKAGE SECTION.
       01 LN       PIC 9(9)  COMP-5.
       01 LRET     PIC 9(18) COMP-5.
       PROCEDURE DIVISION USING LN LRET.
           IF LN < 2
               MOVE LN TO LRET
           ELSE
               COMPUTE M = LN - 1
               CALL 'FIB' USING M A
               COMPUTE M = LN - 2
               CALL 'FIB' USING M B
               COMPUTE LRET = A + B
           END-IF
           GOBACK.
       END PROGRAM FIB.
