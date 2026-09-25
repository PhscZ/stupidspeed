      *> task 09 fib_recursive -- expected output: 102334155
      *> build: cobc -x -O2 -o prog 09_fib_recursive.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T09.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 N        PIC 9(9)  COMP-5.
       01 R        PIC 9(18) COMP-5.
       01 ORR      PIC 9(9).
       PROCEDURE DIVISION.
           MOVE 40 TO N.
           CALL 'FIB' USING N R.
           MOVE R TO ORR.
           DISPLAY ORR.
           STOP RUN.
       END PROGRAM T09.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIB IS RECURSIVE.
       DATA DIVISION.
       LOCAL-STORAGE SECTION.
       01 A        PIC 9(18) COMP-5.
       01 B        PIC 9(18) COMP-5.
       01 M        PIC 9(9)  COMP-5.
       LINKAGE SECTION.
       01 LN       PIC 9(9)  COMP-5.
       01 LRET     PIC 9(18) COMP-5.
       PROCEDURE DIVISION USING LN LRET.
           IF LN < 2
               MOVE LN TO LRET
           ELSE
               COMPUTE M = LN - 1
               CALL 'FIB' USING M A
               COMPUTE M = LN - 2
               CALL 'FIB' USING M B
               COMPUTE LRET = A + B
           END-IF
           GOBACK.
       END PROGRAM FIB.
