      *> task 11 parallel_sum -- expected output: 7500000075000000
      *> build: cobc -x -O2 -o prog 11_parallel_sum.cob    run: ./prog
      *> GnuCOBOL has no threads, so the four workers are four forked processes:
      *> CBL_GC_FORK is GnuCOBOL's own process facility and is the COBOL equivalent
      *> of the R row's forked workers. Each child owns one fixed quarter, writes
      *> its partial sum to its own file, and the parent waits for all four and adds
      *> them up. The four ranges are fixed, so the total does not depend on the
      *> order they finish in.
      *> DEVIATION: CBL_GC_FORK is not available on Windows (GnuCOBOL documents the
      *> exception as "GCC on Cygwin"), where it returns -1 with a warning. The
      *> program then computes the four quarters in-process, so it still prints the
      *> right answer but on one core -- the same fallback the Fortran and Julia rows
      *> take without their thread flag. Genuine parallelism needs a Linux host.
      *> The child files p1.tmp .. p4.tmp are left behind, like task 15's out.bin.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T11.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PART-FILE ASSIGN TO WS-PARTNAME
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WS-STAT.
       DATA DIVISION.
       FILE SECTION.
       FD PART-FILE.
       01 PART-REC PIC 9(16).
       WORKING-STORAGE SECTION.
       01 WS-STAT   PIC XX.
       01 WS-PARTNAME PIC X(8).
       01 WS-DIGIT  PIC 9.
       01 T         PIC 9(9) COMP-5.
       01 I         PIC 9(18) COMP-5.
       01 LO        PIC 9(18) COMP-5.
       01 HI        PIC 9(18) COMP-5.
       01 Q         PIC 9(9) COMP-5.
       01 R         PIC 9(9) COMP-5.
       01 ACC       PIC 9(18) COMP-5.
       01 TOTAL     PIC 9(18) COMP-5.
       01 OT        PIC 9(16).
       01 PIDS.
           05 PID   PIC S9(9) COMP-5 OCCURS 4 TIMES.
       01 CHILD-PID PIC S9(9) COMP-5.
       01 WAIT-STS  PIC S9(9) COMP-5.
       01 USED-FORK PIC X VALUE "N".
       PROCEDURE DIVISION.
           PERFORM VARYING T FROM 1 BY 1 UNTIL T > 4
               CALL "CBL_GC_FORK" RETURNING CHILD-PID
               END-CALL
               IF CHILD-PID = 0
                   PERFORM CHILD-WORK
                   STOP RUN
               END-IF
               IF CHILD-PID > 0
                   MOVE CHILD-PID TO PID(T)
                   MOVE "Y" TO USED-FORK
               ELSE
                   PERFORM CHILD-WORK
               END-IF
           END-PERFORM.
           IF USED-FORK = "Y"
               PERFORM VARYING T FROM 1 BY 1 UNTIL T > 4
                   CALL "CBL_GC_WAITPID" USING PID(T)
                       RETURNING WAIT-STS
                   END-CALL
               END-PERFORM
           END-IF.
           MOVE 0 TO TOTAL.
           PERFORM VARYING T FROM 1 BY 1 UNTIL T > 4
               PERFORM MAKE-NAME
               OPEN INPUT PART-FILE
               READ PART-FILE
                   AT END CONTINUE
                   NOT AT END ADD PART-REC TO TOTAL
               END-READ
               CLOSE PART-FILE
           END-PERFORM.
           MOVE TOTAL TO OT.
           DISPLAY OT.
           STOP RUN.

      *> one quarter: the task 02 switch over [LO, HI]
       CHILD-WORK.
           COMPUTE LO = (T - 1) * 25000000
           COMPUTE HI = T * 25000000 - 1
           MOVE 0 TO ACC
           PERFORM VARYING I FROM LO BY 1 UNTIL I > HI
               DIVIDE I BY 4 GIVING Q REMAINDER R
               EVALUATE R
                   WHEN 0 ADD 1 TO ACC
                   WHEN 1 ADD I TO ACC
                   WHEN 2 COMPUTE ACC = ACC + 2 * I
                   WHEN 3 COMPUTE ACC = ACC + 3 * I
               END-EVALUATE
           END-PERFORM
           PERFORM MAKE-NAME
           OPEN OUTPUT PART-FILE
           MOVE ACC TO PART-REC
           WRITE PART-REC
           CLOSE PART-FILE.

      *> WS-PARTNAME := "p<digit>.tmp"
       MAKE-NAME.
           MOVE T TO WS-DIGIT
           MOVE SPACES TO WS-PARTNAME
           STRING "p" WS-DIGIT ".tmp" DELIMITED BY SIZE
               INTO WS-PARTNAME
           END-STRING.
