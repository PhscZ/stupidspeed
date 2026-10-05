      *> task 07 string_append -- expected output: 250000
      *> build: cobc -x -O2 -o prog 07_string_append.cob    run: ./prog
      *> timing: ACCEPT ... FROM TIME is GnuCOBOL's own clock, hhmmsscc, so the
      *>         resolution is 10 ms; TIME_MS is DISPLAYed UPON STDERR and stdout is
      *>         unchanged. Built and run against GnuCOBOL 3.2 on this machine, so the timing is real.
      *>         The two COMPUTE CS0/CS1 lines were past column 72 and are wrapped.
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
       01 NEWTEXT  PIC X(250000) BASED.
       01 OLDTEXT  PIC X(250000) BASED.
       01 OLEN     PIC 9(9) COMP-5.
       01 OOUT     PIC 9(6).
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
           MOVE 0 TO LEN.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 250000
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
           DISPLAY OOUT.
           STOP RUN.
