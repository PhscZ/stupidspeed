      *> task 15 file_write -- expected output: 104857600
      *> build: cobc -x -O2 -o prog 15_file_write.cob    run: ./prog
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
       01 OUTC     PIC 9(9).
       PROCEDURE DIVISION.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 255
               COMPUTE J = I + 1
               MOVE FUNCTION CHAR(I) TO BYT(J)
           END-PERFORM.
           MOVE 0 TO NWRITTEN.
           OPEN OUTPUT OUT-FILE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100
               MOVE BUF TO OUT-REC
               WRITE OUT-REC
               ADD 1048576 TO NWRITTEN
           END-PERFORM.
           CLOSE OUT-FILE.
           MOVE NWRITTEN TO OUTC.
           DISPLAY OUTC.
           STOP RUN.
