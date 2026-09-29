; task 12 matrix_add — expected output: 999000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 12_matrix_add.ahk
; note: AutoHotkey has no two-dimensional array, so the three matrices are three flat
;       1000000-element Arrays indexed i * n + j, which is the same layout the C row
;       uses. Each element is an AutoHotkey value in an Array object rather than 8 bytes
;       of a packed block, so the three matrices are three object arrays rather than
;       24 MB of contiguous memory. They are pre-sized so no store grows an array.
; note: indices are 1-based, so the flat offset is i * n + j + 1; an out-of-range write
;       would throw IndexError, which is why the sizing is not optional.
; note: every C element is 2i, so the total is 2000 * (0 + ... + 999) = 999000000,
;       inside the 32-bit range and exact in the 64-bit integer type.
; note: the fill, the add and the sum together take about two seconds on this machine.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

n := 1000

A := []
B := []
C := []
A.Length := 1000000
B.Length := 1000000
C.Length := 1000000

Loop n {
    i := A_Index - 1
    Loop n {
        j := A_Index - 1
        A[i * n + j + 1] := i + j
        B[i * n + j + 1] := i - j
    }
}

Loop n {
    i := A_Index - 1
    Loop n {
        j := A_Index - 1
        C[i * n + j + 1] := A[i * n + j + 1] + B[i * n + j + 1]
    }
}

total := 0
Loop 1000000
    total += C[A_Index]

FileAppend(total "`n", "*")
