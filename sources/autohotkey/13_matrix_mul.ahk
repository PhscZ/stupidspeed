; task 13 matrix_mul — expected output: 599995000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 13_matrix_mul.ahk
; note: the matrices are flat 250000-element Arrays indexed i * n + j, the same layout
;       the C row uses; AutoHotkey has no two-dimensional array and the flat form is
;       what the C reference does anyway. Indices are 1-based, so the offset carries a
;       + 1, and the three arrays are pre-sized because an out-of-range write throws.
; note: the loop order is the plain i, j, k the spec asks for, so B is walked down a
;       column at a time. Reordering it would be faster and that is the point of the
;       task, so it is left alone.
; note: each element of C is a sum of 500 terms each at most 6 * 4 = 24, so it fits in
;       a small integer; the grand total, 599995000, does too.
; note: the full run takes about 75 s on this machine, about 0.6 us per inner multiply-add,
;       which is the price of two 1-based Array indexings per term (a pass on the same shared
;       host measured 319 s).
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

n := 500

A := []
B := []
C := []
A.Length := 250000
B.Length := 250000
C.Length := 250000

Loop n {
    i := A_Index - 1
    Loop n {
        j := A_Index - 1
        A[i * n + j + 1] := Mod(i + j, 7)
        B[i * n + j + 1] := Mod(i * j, 5)
    }
}

Loop n {
    i := A_Index - 1
    Loop n {
        j := A_Index - 1
        sum := 0
        Loop n {
            k := A_Index - 1
            sum += A[i * n + k + 1] * B[k * n + j + 1]
        }
        C[i * n + j + 1] := sum
    }
}

total := 0
Loop 250000
    total += C[A_Index]

FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(total "`n", "*")
