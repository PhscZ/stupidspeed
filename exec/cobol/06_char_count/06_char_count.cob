      *> task 06 char_count -- expected output: 10000000
      *> build: cobc -x -O2 -o prog 06_char_count.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Instrumented by inspection: there is no GnuCOBOL toolchain
      *>         on this machine, so this row's timing is unverified.
      *> The 100 MB text is built by repeating the whole 10000-byte block 10000
      *> times, not by appending in a loop, so the build is not the benchmark.
      *> A 100 MB PIC X item is past what WORKING-STORAGE holds comfortably, so
      *> the text lives in one ALLOCATE and is addressed as a BASED item.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T06.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TXTPTR   USAGE POINTER.
       01 TXT      PIC X(100000000) BASED.
       01 BLK      PIC X(10000).
       01 I        PIC 9(9) COMP-5.
       01 J        PIC 9(9) COMP-5.
       01 OFFS     PIC 9(9) COMP-5.
       01 CNT      PIC 9(9) COMP-5.
       01 OC       PIC 9(8).
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
           PERFORM VARYING J FROM 0 BY 1 UNTIL J > 999
               COMPUTE OFFS = J * 10 + 1
               MOVE "abcdefghij" TO BLK(OFFS:10)
           END-PERFORM.
           ALLOCATE 100000000 CHARACTERS RETURNING TXTPTR.
           SET ADDRESS OF TXT TO TXTPTR.
           PERFORM VARYING J FROM 0 BY 1 UNTIL J > 9999
               COMPUTE OFFS = J * 10000 + 1
               MOVE BLK TO TXT(OFFS:10000)
           END-PERFORM.
           MOVE 0 TO CNT.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100000000
               IF TXT(I:1) = "h"
                   ADD 1 TO CNT
               END-IF
           END-PERFORM.
           MOVE CNT TO OC.
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
           DISPLAY OC.
           STOP RUN.
