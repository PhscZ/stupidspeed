      *> task 13 matrix_mul -- expected output: 599995000
      *> build: cobc -x -O2 -o prog 13_matrix_mul.cob    run: ./prog
      *> Plain triple loop, no tricks: the innermost loop walks B down a column,
      *> which is the cache-hostile order the task asks for.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T13.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9) COMP-5.
       01 J        PIC 9(9) COMP-5.
       01 K        PIC 9(9) COMP-5.
       01 ACC      PIC 9(18) COMP-5.
       01 TOTAL    PIC 9(18) COMP-5.
       01 OT       PIC 9(9).
       01 A-ARR.
           05 A-ROW OCCURS 500 TIMES.
               10 AV PIC 9(9) COMP-5 OCCURS 500 TIMES.
       01 B-ARR.
           05 B-ROW OCCURS 500 TIMES.
               10 BV PIC 9(9) COMP-5 OCCURS 500 TIMES.
       01 C-ARR.
           05 C-ROW OCCURS 500 TIMES.
               10 CV PIC 9(18) COMP-5 OCCURS 500 TIMES.
       PROCEDURE DIVISION.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 500
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 500
                   COMPUTE AV(I, J) = FUNCTION MOD(I - 1 + J - 1, 7)
                   COMPUTE BV(I, J) = FUNCTION MOD((I - 1) * (J - 1), 5)
               END-PERFORM
           END-PERFORM.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 500
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 500
                   MOVE 0 TO ACC
                   PERFORM VARYING K FROM 1 BY 1 UNTIL K > 500
                       COMPUTE ACC = ACC + AV(I, K) * BV(K, J)
                   END-PERFORM
                   MOVE ACC TO CV(I, J)
               END-PERFORM
           END-PERFORM.
           MOVE 0 TO TOTAL.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 500
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 500
                   ADD CV(I, J) TO TOTAL
               END-PERFORM
           END-PERFORM.
           MOVE TOTAL TO OT.
           DISPLAY OT.
           STOP RUN.
