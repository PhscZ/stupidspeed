      *> task 02 switch_case -- expected output: 7500000075000000
      *> build: cobc -x -O2 -o prog 02_switch_case.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Instrumented by inspection: there is no GnuCOBOL toolchain
      *>         on this machine, so this row's timing is unverified.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T02.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 ACC      PIC 9(18) COMP-5.
       01 Q        PIC 9(9)  COMP-5.
       01 R        PIC 9(9)  COMP-5.
       01 OUT-ACC  PIC 9(16).
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
           DISPLAY OUT-ACC.
           STOP RUN.
