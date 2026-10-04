      *> task 14 file_read -- expected output: 2389704704
      *> build: cobc -x -O2 -o prog 14_file_read.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Instrumented by inspection: there is no GnuCOBOL toolchain
      *>         on this machine, so this row's timing is unverified.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T14.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE ASSIGN TO "data.bin"
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WS-STAT.
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE.
       01 IN-REC PIC X(1048576).
       WORKING-STORAGE SECTION.
       01 WS-STAT   PIC XX.
       01 I         PIC 9(9)  COMP-5.
       01 B         PIC 9(9)  COMP-5.
       01 TOTAL     PIC 9(18) COMP-5.
       01 OT        PIC 9(9).
       01 EOF-F    PIC X VALUE "N".
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
           OPEN INPUT IN-FILE.
           MOVE 0 TO TOTAL.
           PERFORM UNTIL EOF-F = "Y"
               READ IN-FILE INTO IN-REC
                   AT END MOVE "Y" TO EOF-F
                   NOT AT END
                       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 1048576
                           COMPUTE B = FUNCTION ORD(IN-REC(I:1)) - 1
                           ADD B TO TOTAL
                       END-PERFORM
               END-READ
           END-PERFORM.
           CLOSE IN-FILE.
           COMPUTE TOTAL = FUNCTION MOD(TOTAL, 4294967296).
           MOVE TOTAL TO OT.
           ACCEPT WS-T1 FROM TIME.
           COMPUTE CS0 = ((((T0-HH * 60) + T0-MM) * 60) + T0-SS) * 100 + T0-CC.
           COMPUTE CS1 = ((((T1-HH * 60) + T1-MM) * 60) + T1-SS) * 100 + T1-CC.
           IF CS1 < CS0
               ADD 8640000 TO CS1
           END-IF.
           COMPUTE MS = (CS1 - CS0) * 10.
           DISPLAY "TIME_MS=" MS UPON STDERR.
           DISPLAY OT.
           STOP RUN.
