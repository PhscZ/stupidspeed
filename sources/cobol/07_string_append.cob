      *> task 07 string_append -- expected output: 1000000
      *> build: cobc -x -O2 -o prog 07_string_append.cob    run: ./prog
      *> COBOL strings are fixed length and have no growable form, so the growing
      *> string lives in an ALLOCATE that is rebound to the freshly copied value
      *> each iteration; the replaced buffer is freed explicitly, as Ada's row
      *> does. Every append therefore copies the whole string, which is the
      *> property the task is measuring.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T07.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I        PIC 9(9) COMP-5.
       01 LEN      PIC 9(9) COMP-5.
       01 NEWPTR   USAGE POINTER.
       01 OLDPTR   USAGE POINTER.
       01 NEWTEXT  PIC X(1000000) BASED.
       01 OLDTEXT  PIC X(1000000) BASED.
       01 OLEN     PIC 9(9) COMP-5.
       01 OOUT     PIC 9(7).
       PROCEDURE DIVISION.
           MOVE 0 TO LEN.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 1000000
               ALLOCATE I CHARACTERS RETURNING NEWPTR
               SET ADDRESS OF NEWTEXT TO NEWPTR
               IF LEN > 0
                   MOVE OLDTEXT(1:LEN) TO NEWTEXT(1:LEN)
                   FREE OLDPTR
               END-IF
               MOVE "x" TO NEWTEXT(I:1)
               ADD 1 TO LEN
               SET OLDPTR TO NEWPTR
               SET ADDRESS OF OLDTEXT TO OLDPTR
           END-PERFORM.
           MOVE LEN TO OOUT.
           DISPLAY OOUT.
           STOP RUN.
