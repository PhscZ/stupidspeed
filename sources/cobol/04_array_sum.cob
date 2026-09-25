      *> task 04 array_sum -- expected output: 499999500000
      *> build: cobc -x -O2 -o prog 04_array_sum.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T04.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 TOTAL    PIC 9(18) COMP-5.
       01 OT       PIC 9(12).
       01 ARR.
           05 ELEM PIC 9(9) COMP-5 OCCURS 1000000 TIMES.
       PROCEDURE DIVISION.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 999999
               MOVE I TO ELEM(I + 1)
           END-PERFORM.
           MOVE 0 TO TOTAL.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 999999
               ADD ELEM(I + 1) TO TOTAL
           END-PERFORM.
           MOVE TOTAL TO OT.
           DISPLAY OT.
           STOP RUN.
