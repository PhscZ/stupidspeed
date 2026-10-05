      *> task 05 alloc_churn -- expected output: 1274991808
      *> build: cobc -x -O2 -o prog 05_alloc_churn.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Built and run against GnuCOBOL 3.2 on this machine, so the timing is real.
      *>         The two COMPUTE CS0/CS1 lines were past column 72 and are wrapped.
      *> COBOL has no garbage collector, so the slot store frees the buffer it
      *> replaces: that is the "free the old one" branch of the C reference.
      *> ALLOCATE/FREE are GnuCOBOL's heap interface, and the byte goes through
      *> the allocated buffer rather than around it, so the allocation is live.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T05.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9)  COMP-5.
       01 K        PIC 9(9)  COMP-5.
       01 B0       PIC 9(9)  COMP-5.
       01 TOTAL    PIC 9(18) COMP-5.
       01 OT       PIC 9(10).
       01 BUF      USAGE POINTER.
       01 OLDBUF   USAGE POINTER.
       01 REC      PIC X(64) BASED.
       01 SLOTS.
           05 SLOT USAGE POINTER OCCURS 256 TIMES.
       01 FILLED   PIC X VALUE "N".
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
           MOVE 0 TO TOTAL.
           MOVE "N" TO FILLED.
           PERFORM VARYING I FROM 0 BY 1 UNTIL I > 9999999
               ALLOCATE 64 CHARACTERS RETURNING BUF
               SET ADDRESS OF REC TO BUF
               COMPUTE B0 = FUNCTION MOD(I, 256)
               MOVE FUNCTION CHAR(B0 + 1) TO REC(1:1)
               COMPUTE B0 = FUNCTION ORD(REC(1:1)) - 1
               ADD B0 TO TOTAL
               COMPUTE K = B0 + 1
               IF FILLED = "Y"
                   SET OLDBUF TO SLOT(K)
                   FREE OLDBUF
               END-IF
               SET SLOT(K) TO BUF
               MOVE "Y" TO FILLED
           END-PERFORM.
           MOVE TOTAL TO OT.
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
           DISPLAY OT.
           STOP RUN.
