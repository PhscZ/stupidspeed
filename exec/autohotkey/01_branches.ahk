; task 01 branches — expected output: 33333334 13333333 7619048 45714285
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 01_branches.ahk
; note: AutoHotkey's only numeric type is the 64-bit signed integer, so every counter
;       and every total in this row is exact and is printed by the plain string
;       conversion; there is no promotion and no formatting helper anywhere.
; note: the loop variable is written as A_Index - 1 rather than carried in a register,
;       because A_Index is the language's own loop counter and starts at 1.
; note: the full 100000000-iteration run takes about 50 s on this machine. The host is shared
;       with other benchmark runs, and a second pass on it measured 172 s for the same loop,
;       so read the cell as "under a minute on a quiet machine" rather than as a precise
;       figure.
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

a := 0
b := 0
c := 0
d := 0

Loop 100000000 {
    i := A_Index - 1
    if (Mod(i, 3) = 0)
        a += 1
    else if (Mod(i, 5) = 0)
        b += 1
    else if (Mod(i, 7) = 0)
        c += 1
    else
        d += 1
}

FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(a " " b " " c " " d "`n", "*")
