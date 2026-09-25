      *> task 06 char_count -- expected output: 10000000
      *> build: cobc -x -O2 -o prog 06_char_count.cob    run: ./prog
      *> The 100 MB text is built by repeating the whole 10000-byte block 10000
      *> times, not by appending in a loop, so the build is not the benchmark.
      *> A 100 MB PIC X item is past what WORKING-STORAGE holds comfortably, so
      *> the text lives in one ALLOCATE and is addressed as a BASED item.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T06.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TXTPTR   USAGE POINTER.
       01 TXT      PIC X(100000000) BASED.
       01 BLK      PIC X(10000).
       01 I        PIC 9(9) COMP-5.
       01 J        PIC 9(9) COMP-5.
       01 OFFS     PIC 9(9) COMP-5.
       01 CNT      PIC 9(9) COMP-5.
       01 OC       PIC 9(8).
       PROCEDURE DIVISION.
           PERFORM VARYING J FROM 0 BY 1 UNTIL J > 999
               COMPUTE OFFS = J * 10 + 1
               MOVE "abcdefghij" TO BLK(OFFS:10)
           END-PERFORM.
           ALLOCATE 100000000 CHARACTERS RETURNING TXTPTR.
           SET ADDRESS OF TXT TO TXTPTR.
           PERFORM VARYING J FROM 0 BY 1 UNTIL J > 9999
               COMPUTE OFFS = J * 10000 + 1
               MOVE BLK TO TXT(OFFS:10000)
           END-PERFORM.
           MOVE 0 TO CNT.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100000000
               IF TXT(I:1) = "h"
                   ADD 1 TO CNT
               END-IF
           END-PERFORM.
           MOVE CNT TO OC.
           DISPLAY OC.
           STOP RUN.
