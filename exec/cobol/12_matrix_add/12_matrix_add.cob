      *> task 12 matrix_add -- expected output: 999000000
      *> build: cobc -x -O2 -o prog 12_matrix_add.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Instrumented by inspection: there is no GnuCOBOL toolchain
      *>         on this machine, so this row's timing is unverified.
      *> Three 1000x1000 arrays of 8-byte integers, 24 MB, too big for cache.
      *> COMP-5 is the native binary type, so each cell is a real 64-bit word.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T12.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9) COMP-5.
       01 J        PIC 9(9) COMP-5.
       01 TOTAL    PIC S9(18) COMP-5.
       01 OT       PIC 9(9).
       01 A-ARR.
           05 A-ROW OCCURS 1000 TIMES.
               10 AV PIC S9(18) COMP-5 OCCURS 1000 TIMES.
       01 B-ARR.
           05 B-ROW OCCURS 1000 TIMES.
               10 BV PIC S9(18) COMP-5 OCCURS 1000 TIMES.
       01 C-ARR.
           05 C-ROW OCCURS 1000 TIMES.
               10 CV PIC S9(18) COMP-5 OCCURS 1000 TIMES.
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
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 1000
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 1000
                   COMPUTE AV(I, J) = I - 1 + J - 1
                   COMPUTE BV(I, J) = I - 1 - (J - 1)
               END-PERFORM
           END-PERFORM.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 1000
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 1000
                   COMPUTE CV(I, J) = AV(I, J) + BV(I, J)
               END-PERFORM
           END-PERFORM.
           MOVE 0 TO TOTAL.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 1000
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 1000
                   ADD CV(I, J) TO TOTAL
               END-PERFORM
           END-PERFORM.
           MOVE TOTAL TO OT.
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
           DISPLAY OT.
           STOP RUN.
