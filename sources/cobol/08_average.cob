      *> task 08 average -- expected output: 0.498046875
      *> build: cobc -x -O2 -o prog 08_average.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T08.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 R        PIC 9(9)  COMP-5.
       01 TOTAL    COMP-2.
       01 OUTV     PIC 9(1).9(9).
       PROCEDURE DIVISION.
           MOVE 0 TO TOTAL.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 99999999
               COMPUTE R = FUNCTION MOD(I, 256)
               COMPUTE TOTAL = TOTAL + R / 256.0
           END-PERFORM.
           COMPUTE TOTAL = TOTAL / 100000000.
           MOVE TOTAL TO OUTV.
           DISPLAY OUTV.
           STOP RUN.
