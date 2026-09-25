      *> task 10 pi -- expected output: 44889
      *> build: cobc -x -O2 -o prog 10_pi.cob    run: ./prog
      *> COBOL has no big integers, so this is the GDScript/BASIC/Pascal
      *> precedent: sign-magnitude big integers on base-1e9 limbs with the four
      *> operations Gibbons' unbounded spigot needs. Only the digit sum is
      *> printed, so the check is one number.
      *> COMP-5 gives the full 64-bit binary range regardless of the PICTURE, so a
      *> limb product plus carry fits in one COMPUTE with no overflow handling.
      *> 17000 limbs is what the BASIC row uses for 10000 digits; t peaks near
      *> 16192 limbs, so the arrays are never indexed past their end.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. T10.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 QUOT-HI  PIC 9(9) COMP-5 VALUE 1023.
       01 NDIGITS  PIC 9(9) COMP-5 VALUE 10000.
       01 Q.
           05 Q-NEG  PIC 9 COMP-5.
           05 Q-N    PIC 9(9) COMP-5.
           05 Q-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 R.
           05 R-NEG  PIC 9 COMP-5.
           05 R-N    PIC 9(9) COMP-5.
           05 R-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 T.
           05 T-NEG  PIC 9 COMP-5.
           05 T-N    PIC 9(9) COMP-5.
           05 T-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 NT.
           05 NT-NEG PIC 9 COMP-5.
           05 NT-N   PIC 9(9) COMP-5.
           05 NT-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 LHS.
           05 LHS-NEG PIC 9 COMP-5.
           05 LHS-N   PIC 9(9) COMP-5.
           05 LHS-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 TMP1.
           05 T1-NEG PIC 9 COMP-5.
           05 T1-N   PIC 9(9) COMP-5.
           05 T1-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 TMP2.
           05 T2-NEG PIC 9 COMP-5.
           05 T2-N   PIC 9(9) COMP-5.
           05 T2-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 TMP3.
           05 T3-NEG PIC 9 COMP-5.
           05 T3-N   PIC 9(9) COMP-5.
           05 T3-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 TL.
           05 TL-NEG PIC 9 COMP-5.
           05 TL-N   PIC 9(9) COMP-5.
           05 TL-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 NB.
           05 NB-NEG PIC 9 COMP-5.
           05 NB-N   PIC 9(9) COMP-5.
           05 NB-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 K        PIC 9(18) COMP-5.
       01 L        PIC 9(18) COMP-5.
       01 NN       PIC 9(18) COMP-5.
       01 NEXTN    PIC 9(18) COMP-5.
       01 S        PIC 9(18) COMP-5.
       01 CMPRES   PIC S9(9) COMP-5.
       01 TOTAL    PIC 9(9) COMP-5.
       01 EMITTED  PIC 9(9) COMP-5.
       01 OT       PIC 9(5).
       PROCEDURE DIVISION.
           MOVE 0 TO Q-NEG
           MOVE 1 TO Q-N
           MOVE 1 TO Q-D(1)
           MOVE 0 TO R-NEG
           MOVE 1 TO R-N
           MOVE 0 TO R-D(1)
           MOVE 0 TO T-NEG
           MOVE 1 TO T-N
           MOVE 1 TO T-D(1)
           MOVE 1 TO K
           MOVE 3 TO NN
           MOVE 3 TO L
           MOVE 0 TO TOTAL
           MOVE 0 TO EMITTED
           PERFORM UNTIL EMITTED >= NDIGITS
               MOVE NN TO S
               CALL 'BIGMUL' USING NT T S
               CALL 'BIGMUL' USING TMP1 Q 4
               CALL 'BIGADD' USING TMP2 TMP1 R
               CALL 'BIGSUB' USING LHS TMP2 T NB
               CALL 'BIGCMP' USING LHS NT CMPRES
               IF CMPRES < 0
                   ADD NN TO TOTAL
                   ADD 1 TO EMITTED
                   CALL 'BIGMUL' USING TMP1 Q 3
                   CALL 'BIGADD' USING TMP2 TMP1 R
                   CALL 'BIGMUL' USING TMP3 TMP2 10
                   CALL 'BIGDIVQ' USING TMP3 T QUOT-HI NEXTN
                   COMPUTE NEXTN = NEXTN - 10 * NN
                   CALL 'BIGMUL' USING TMP1 Q 10
                   CALL 'BIGCOPY' USING Q TMP1
                   CALL 'BIGSUB' USING TMP2 R NT NB
                   CALL 'BIGMUL' USING TMP1 TMP2 10
                   CALL 'BIGCOPY' USING R TMP1
                   MOVE NEXTN TO NN
               ELSE
                   COMPUTE S = 7 * K + 2
                   CALL 'BIGMUL' USING TMP1 Q S
                   MOVE L TO S
                   CALL 'BIGMUL' USING TMP2 R S
                   CALL 'BIGADD' USING TMP3 TMP1 TMP2
                   MOVE L TO S
                   CALL 'BIGMUL' USING TL T S
                   CALL 'BIGDIVQ' USING TMP3 TL QUOT-HI NN
                   CALL 'BIGMUL' USING TMP1 Q 2
                   CALL 'BIGADD' USING TMP2 TMP1 R
                   MOVE L TO S
                   CALL 'BIGMUL' USING TMP1 TMP2 S
                   CALL 'BIGCOPY' USING R TMP1
                   MOVE K TO S
                   CALL 'BIGMUL' USING TMP1 Q S
                   CALL 'BIGCOPY' USING Q TMP1
                   CALL 'BIGCOPY' USING T TL
                   ADD 1 TO K
                   ADD 2 TO L
               END-IF
           END-PERFORM.
           MOVE TOTAL TO OT.
           DISPLAY OT.
           STOP RUN.
       END PROGRAM T10.

      *> drop high zero limbs; a zero value always has NEG = 0
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGTRIM.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       LINKAGE SECTION.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING A.
           PERFORM UNTIL A-N <= 1
               IF A-D(A-N) NOT = 0
                   EXIT PERFORM
               END-IF
               SUBTRACT 1 FROM A-N
           END-PERFORM.
           IF A-N = 1 AND A-D(1) = 0
               MOVE 0 TO A-NEG
           END-IF.
           GOBACK.
       END PROGRAM BIGTRIM.

      *> O := A
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGCOPY.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I         PIC 9(9) COMP-5.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING O A.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > A-N
               MOVE A-D(I) TO O-D(I)
           END-PERFORM.
           MOVE A-N TO O-N.
           MOVE A-NEG TO O-NEG.
           GOBACK.
       END PROGRAM BIGCOPY.

      *> RES := sign of |A| - |B|
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAGCMP.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I         PIC S9(9) COMP-5.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       LINKAGE SECTION.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 RES       PIC S9(9) COMP-5.
       PROCEDURE DIVISION USING A B RES.
           IF A-N > B-N
               MOVE 1 TO RES
               GOBACK
           END-IF
           IF A-N < B-N
               MOVE -1 TO RES
               GOBACK
           END-IF
           MOVE 0 TO RES
           PERFORM VARYING I FROM A-N BY -1 UNTIL I < 1
               IF A-D(I) > B-D(I)
                   MOVE 1 TO RES
                   EXIT PERFORM
               END-IF
               IF A-D(I) < B-D(I)
                   MOVE -1 TO RES
                   EXIT PERFORM
               END-IF
           END-PERFORM.
           GOBACK.
       END PROGRAM MAGCMP.

      *> RES := sign of A - B, signed
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGCMP.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       LINKAGE SECTION.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 RES       PIC S9(9) COMP-5.
       PROCEDURE DIVISION USING A B RES.
           IF A-NEG NOT = B-NEG
               IF A-NEG = 1
                   MOVE -1 TO RES
               ELSE
                   MOVE 1 TO RES
               END-IF
               GOBACK
           END-IF
           CALL 'MAGCMP' USING A B RES
           IF A-NEG = 1
               COMPUTE RES = 0 - RES
           END-IF.
           GOBACK.
       END PROGRAM BIGCMP.

      *> O := |A| + |B|
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAGADD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 I         PIC 9(9) COMP-5.
       01 NN        PIC 9(9) COMP-5.
       01 CARRY     PIC 9(18) COMP-5.
       01 CUR       PIC 9(18) COMP-5.
       01 QQ        PIC 9(18) COMP-5.
       01 RR        PIC 9(18) COMP-5.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING O A B.
           MOVE 0 TO CARRY
           IF A-N > B-N
               MOVE A-N TO NN
           ELSE
               MOVE B-N TO NN
           END-IF
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > NN
               MOVE CARRY TO CUR
               IF I <= A-N
                   ADD A-D(I) TO CUR
               END-IF
               IF I <= B-N
                   ADD B-D(I) TO CUR
               END-IF
               DIVIDE CUR BY LIMB-BASE GIVING QQ REMAINDER RR
               MOVE RR TO O-D(I)
               MOVE QQ TO CARRY
           END-PERFORM
           ADD 1 TO NN
           MOVE CARRY TO O-D(NN)
           MOVE NN TO O-N
           MOVE 0 TO O-NEG
           CALL 'BIGTRIM' USING O.
           GOBACK.
       END PROGRAM MAGADD.

      *> O := |A| - |B|, requires |A| >= |B|
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAGSUB.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 I         PIC 9(9) COMP-5.
       01 BORROW    PIC 9(18) COMP-5.
       01 CUR       PIC S9(18) COMP-5.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING O A B.
           MOVE 0 TO BORROW
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > A-N
               MOVE A-D(I) TO CUR
               SUBTRACT BORROW FROM CUR
               IF I <= B-N
                   SUBTRACT B-D(I) FROM CUR
               END-IF
               IF CUR < 0
                   ADD LIMB-BASE TO CUR
                   MOVE 1 TO BORROW
               ELSE
                   MOVE 0 TO BORROW
               END-IF
               MOVE CUR TO O-D(I)
           END-PERFORM
           MOVE A-N TO O-N
           MOVE 0 TO O-NEG
           CALL 'BIGTRIM' USING O.
           GOBACK.
       END PROGRAM MAGSUB.

      *> O := A + B, signed
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGADD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 RES       PIC S9(9) COMP-5.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING O A B.
           IF A-NEG = B-NEG
               CALL 'MAGADD' USING O A B
               MOVE A-NEG TO O-NEG
               CALL 'BIGTRIM' USING O
               GOBACK
           END-IF
           CALL 'MAGCMP' USING A B RES
           IF RES = 0
               MOVE 1 TO O-N
               MOVE 0 TO O-D(1)
               MOVE 0 TO O-NEG
               GOBACK
           END-IF
           IF RES > 0
               CALL 'MAGSUB' USING O A B
               MOVE A-NEG TO O-NEG
           ELSE
               CALL 'MAGSUB' USING O B A
               MOVE B-NEG TO O-NEG
           END-IF
           CALL 'BIGTRIM' USING O.
           GOBACK.
       END PROGRAM BIGADD.

      *> O := A - B, signed; NB is caller-supplied scratch so this stays non-recursive
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGSUB.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 ZERO-F    PIC 9 COMP-5.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 B.
           05 B-NEG  PIC 9 COMP-5.
           05 B-N    PIC 9(9) COMP-5.
           05 B-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 NB.
           05 NB-NEG PIC 9 COMP-5.
           05 NB-N   PIC 9(9) COMP-5.
           05 NB-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       PROCEDURE DIVISION USING O A B NB.
           CALL 'BIGCOPY' USING NB B
           MOVE 0 TO ZERO-F
           IF NB-N = 1 AND NB-D(1) = 0
               MOVE 1 TO ZERO-F
           END-IF
           IF ZERO-F = 0
               IF NB-NEG = 1
                   MOVE 0 TO NB-NEG
               ELSE
                   MOVE 1 TO NB-NEG
               END-IF
           END-IF
           CALL 'BIGADD' USING O A NB.
           GOBACK.
       END PROGRAM BIGSUB.

      *> O := A * M, M >= 0, sign preserved; O must not be A
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGMUL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 I         PIC 9(9) COMP-5.
       01 CARRY     PIC 9(18) COMP-5.
       01 CUR       PIC 9(18) COMP-5.
       01 QQ        PIC 9(18) COMP-5.
       01 RR        PIC 9(18) COMP-5.
       LINKAGE SECTION.
       01 O.
           05 O-NEG  PIC 9 COMP-5.
           05 O-N    PIC 9(9) COMP-5.
           05 O-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 A.
           05 A-NEG  PIC 9 COMP-5.
           05 A-N    PIC 9(9) COMP-5.
           05 A-D    PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 M         PIC 9(18) COMP-5.
       PROCEDURE DIVISION USING O A M.
           IF M = 0
               MOVE 1 TO O-N
               MOVE 0 TO O-D(1)
               MOVE 0 TO O-NEG
               GOBACK
           END-IF
           IF A-N = 1 AND A-D(1) = 0
               MOVE 1 TO O-N
               MOVE 0 TO O-D(1)
               MOVE 0 TO O-NEG
               GOBACK
           END-IF
           MOVE 0 TO CARRY
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > A-N
               COMPUTE CUR = A-D(I) * M + CARRY
               DIVIDE CUR BY LIMB-BASE GIVING QQ REMAINDER RR
               MOVE RR TO O-D(I)
               MOVE QQ TO CARRY
           END-PERFORM
           COMPUTE O-N = A-N + 1
           MOVE CARRY TO O-D(O-N)
           MOVE A-NEG TO O-NEG
           CALL 'BIGTRIM' USING O.
           GOBACK.
       END PROGRAM BIGMUL.

      *> RES := floor(NUM / DIV) for NUM >= 0, DIV > 0, true quotient <= HI.
      *> Binary search on DIV*estimate against NUM: no big-by-big division needed,
      *> which is the same trick the GDScript, Pascal and BASIC rows use.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BIGDIVQ.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LIMB-BASE PIC 9(18) COMP-5 VALUE 1000000000.
       01 LO        PIC 9(18) COMP-5.
       01 HI2       PIC 9(18) COMP-5.
       01 MD        PIC 9(18) COMP-5.
       01 CMPCC     PIC S9(9) COMP-5.
       01 PROBE.
           05 PB-NEG PIC 9 COMP-5.
           05 PB-N   PIC 9(9) COMP-5.
           05 PB-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       LINKAGE SECTION.
       01 NUM.
           05 NUM-NEG PIC 9 COMP-5.
           05 NUM-N   PIC 9(9) COMP-5.
           05 NUM-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 DIV.
           05 DIV-NEG PIC 9 COMP-5.
           05 DIV-N   PIC 9(9) COMP-5.
           05 DIV-D   PIC 9(9) COMP-5 OCCURS 17000 TIMES.
       01 HI        PIC 9(9) COMP-5.
       01 RES       PIC 9(18) COMP-5.
       PROCEDURE DIVISION USING NUM DIV HI RES.
           IF NUM-N < DIV-N
               MOVE 0 TO RES
               GOBACK
           END-IF
           MOVE 0 TO LO
           MOVE HI TO HI2
           PERFORM UNTIL LO >= HI2
               COMPUTE MD = LO + (HI2 - LO + 1) / 2
               CALL 'BIGMUL' USING PROBE DIV MD
               CALL 'MAGCMP' USING PROBE NUM CMPCC
               IF CMPCC <= 0
                   MOVE MD TO LO
               ELSE
                   COMPUTE HI2 = MD - 1
               END-IF
           END-PERFORM
           MOVE LO TO RES.
           GOBACK.
       END PROGRAM BIGDIVQ.
