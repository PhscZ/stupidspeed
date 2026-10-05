; task 02 switch_case — expected output: 7500000075000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 02_switch_case.ahk
; note: Switch is AutoHotkey v2's own switch statement and is used here as the
;       language's switch, exactly as the C row uses switch and the Raku row uses
;       given/when. It is a chain of comparisons in the interpreter, not a jump table.
; note: acc reaches 7500000075000000, which is past 2^32 and past 2^53 but well inside
;       the 64-bit signed range, so it is exact integer arithmetic and the printed
;       value is the exact answer. AutoHotkey's string conversion does not switch to
;       scientific notation for integers, so no formatting helper is needed.
; note: the full 100000000-iteration run takes about 34 s on this machine; a pass on the same
;       shared host measured 180 s for it, so the number is load-dependent.
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

acc := 0

Loop 100000000 {
    i := A_Index - 1
    Switch Mod(i, 4) {
        Case 0: acc += 1
        Case 1: acc += i
        Case 2: acc += 2 * i
        Case 3: acc += 3 * i
    }
}

FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(acc "`n", "*")
