! task 13 matrix_mul — expected output: 599995000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 13_matrix_mul.factor    (from sources/factor/)
! note: the plain triple loop, kept in the i,j,k order the task gives, so the k loop walks
!       B with a stride of n and every element of B is touched 500 times. A, B and C are
!       flat n*n arrays indexed as i*n+j; the dot product and the row sum are separate words
!       so each inner loop stays a simple two-index loop.

USING: arrays locals math prettyprint sequences ;
IN: scratchpad

:: dot-row ( i j n a b -- s )
    0 n [| s k |
        s i n * k + a nth k n * j + b nth * +
    ] each-integer ;

:: row-sum ( i n c -- s )
    0 n [| s j | s i n * j + c nth + ] each-integer ;

:: matrix-mul ( -- total )
    500 :> n
    n n * 0 <array> :> a
    n n * 0 <array> :> b
    n n * 0 <array> :> c
    n [| i |
        n [| j |
            i j + 7 mod i n * j + a set-nth
        ] each-integer
    ] each-integer
    n [| i |
        n [| j |
            i j * 5 mod i n * j + b set-nth
        ] each-integer
    ] each-integer
    n [| i |
        n [| j |
            i j n a b dot-row :> s
            s i n * j + c set-nth
        ] each-integer
    ] each-integer
    0 n [| total i | total i n c row-sum + ] each-integer ;

matrix-mul .
