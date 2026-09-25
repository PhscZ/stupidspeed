      *> task 03 func_sum -- expected output: 100000000
      *> build: cobc -x -O2 -o prog 03_func_sum.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T03.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 V        PIC 9(18) COMP-5.
       01 OV       PIC 9(9).
       01 I        PIC 9(9)  COMP-5.
       PROCEDURE DIVISION.
           MOVE 0 TO V.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 99999999
               CALL 'ADDONE' USING V
           END-PERFORM.
           MOVE V TO OV.
           DISPLAY OV.
           STOP RUN.
       END PROGRAM T03.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADDONE.
       DATA DIVISION.
       LINKAGE SECTION.
       01 LN       PIC 9(18) COMP-5.
       PROCEDURE DIVISION USING LN.
           ADD 1 TO LN.
           GOBACK.
       END PROGRAM ADDONE.
