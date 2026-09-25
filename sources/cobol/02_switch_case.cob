      *> task 02 switch_case -- expected output: 7500000075000000
      *> build: cobc -x -O2 -o prog 02_switch_case.cob    run: ./prog
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T02.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 ACC      PIC 9(18) COMP-5.
       01 Q        PIC 9(9)  COMP-5.
       01 R        PIC 9(9)  COMP-5.
       01 OUT-ACC  PIC 9(16).
       PROCEDURE DIVISION.
           MOVE 0 TO ACC.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 99999999
               DIVIDE I BY 4 GIVING Q REMAINDER R
               EVALUATE R
                   WHEN 0 ADD 1 TO ACC
                   WHEN 1 ADD I TO ACC
                   WHEN 2 COMPUTE ACC = ACC + 2 * I
                   WHEN 3 COMPUTE ACC = ACC + 3 * I
               END-EVALUATE
           END-PERFORM.
           MOVE ACC TO OUT-ACC.
           DISPLAY OUT-ACC.
           STOP RUN.
