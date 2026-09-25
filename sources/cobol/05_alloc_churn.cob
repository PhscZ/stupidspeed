      *> task 05 alloc_churn -- expected output: 1274991808
      *> build: cobc -x -O2 -o prog 05_alloc_churn.cob    run: ./prog
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
       PROCEDURE DIVISION.
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
           DISPLAY OT.
           STOP RUN.
