      *> task 15 file_write -- expected output: 52428800
      *> build: cobc -x -O2 -o prog 15_file_write.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Built and run against GnuCOBOL 3.2 on this machine, so the timing is real.
      *>         The two COMPUTE CS0/CS1 lines were past column 72 and are wrapped.
      *> The 1 MiB record is the 256-byte cycle 0..255 repeated 4096 times, built
      *> once and then written 50 times. FUNCTION CHAR is 1-based: CHAR(1) is
      *> byte 0 and CHAR(256) is byte 255, so the ordinal for byte n is n + 1.
      *> GnuCOBOL has no fsync in its standard library, so the deviation is
      *> flush + close, the same one the D, Julia, Nim, Dart and Pascal rows note.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T15.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OUT-FILE ASSIGN TO "out.bin"
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WS-STAT.
       DATA DIVISION.
       FILE SECTION.
       FD OUT-FILE.
       01 OUT-REC PIC X(1048576).
       WORKING-STORAGE SECTION.
       01 WS-STAT   PIC XX.
       01 I         PIC 9(9) COMP-5.
       01 J         PIC 9(9) COMP-5.
       01 K         PIC 9(9) COMP-5.
       01 BUF.
           05 BYT PIC X(1) OCCURS 256 TIMES.
       01 NWRITTEN  PIC 9(9) COMP-5.
       01 OUTC     PIC 9(8).
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
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 255
               COMPUTE J = I + 1
               MOVE FUNCTION CHAR(J) TO BYT(J)
           END-PERFORM.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 4095
               COMPUTE K = I * 256 + 1
               MOVE BUF TO OUT-REC(K:256)
           END-PERFORM.
           MOVE 0 TO NWRITTEN.
           OPEN OUTPUT OUT-FILE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 50
               WRITE OUT-REC
               ADD 1048576 TO NWRITTEN
           END-PERFORM.
           CLOSE OUT-FILE.
           MOVE NWRITTEN TO OUTC.
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
           DISPLAY OUTC.
           STOP RUN.
