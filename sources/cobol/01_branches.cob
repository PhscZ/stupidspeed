      *> task 01 branches -- expected output: 33333334 13333333 7619048 45714285
      *> build: cobc -x -O2 -o prog 01_branches.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T01.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 A        PIC 9(18) COMP-5.
       01 B        PIC 9(18) COMP-5.
       01 C        PIC 9(18) COMP-5.
       01 D        PIC 9(18) COMP-5.
       01 Q        PIC 9(9)  COMP-5.
       01 R        PIC 9(9)  COMP-5.
       01 OA       PIC 9(8).
       01 OB       PIC 9(8).
       01 OC       PIC 9(7).
       01 OD       PIC 9(8).
       PROCEDURE DIVISION.
           MOVE 0 TO A B C D.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 99999999
               DIVIDE I BY 3 GIVING Q REMAINDER R
               IF R = 0
                   ADD 1 TO A
               ELSE
                   DIVIDE I BY 5 GIVING Q REMAINDER R
                   IF R = 0
                       ADD 1 TO B
                   ELSE
                       DIVIDE I BY 7 GIVING Q REMAINDER R
                       IF R = 0
                           ADD 1 TO C
                       ELSE
                           ADD 1 TO D
                       END-IF
                   END-IF
               END-IF
           END-PERFORM.
           MOVE A TO OA.
           MOVE B TO OB.
           MOVE C TO OC.
           MOVE D TO OD.
           DISPLAY OA " " OB " " OC " " OD.
           STOP RUN.
