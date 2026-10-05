      *> task 01 branches -- expected output: 33333334 13333333 7619048 45714285
      *> build: cobc -x -O2 -o prog 01_branches.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Built and run against GnuCOBOL 3.2 on this machine, so the timing is real.
      *>         The two COMPUTE CS0/CS1 lines were past column 72 and are wrapped.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T01.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 A        PIC 9(18) COMP-5.
       01 B        PIC 9(18) COMP-5.
       01 C        PIC 9(18) COMP-5.
       01 D        PIC 9(18) COMP-5.
       01 Q        PIC 9(9)  COMP-5.
       01 R        PIC 9(9)  COMP-5.
       01 OA       PIC 9(8).
       01 OB       PIC 9(8).
       01 OC       PIC 9(7).
       01 OD       PIC 9(8).
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
           MOVE 0 TO A B C D.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 99999999
               DIVIDE I BY 3 GIVING Q REMAINDER R
               IF R = 0
                   ADD 1 TO A
               ELSE
                   DIVIDE I BY 5 GIVING Q REMAINDER R
                   IF R = 0
                       ADD 1 TO B
                   ELSE
                       DIVIDE I BY 7 GIVING Q REMAINDER R
                       IF R = 0
                           ADD 1 TO C
                       ELSE
                           ADD 1 TO D
                       END-IF
                   END-IF
               END-IF
           END-PERFORM.
           MOVE A TO OA.
           MOVE B TO OB.
           MOVE C TO OC.
           MOVE D TO OD.
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
           DISPLAY OA " " OB " " OC " " OD.
           STOP RUN.
