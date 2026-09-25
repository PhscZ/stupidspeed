      *> task 14 file_read -- expected output: 484442112
      *> build: cobc -x -O2 -o prog 14_file_read.cob    run: ./prog
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
       01 EOF-F     PIC X VALUE "N".
       PROCEDURE DIVISION.
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
           DISPLAY OT.
           STOP RUN.
