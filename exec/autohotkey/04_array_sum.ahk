; task 04 array_sum — expected output: 499999500000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 04_array_sum.ahk
; note: AutoHotkey's arrays are 1-based objects, not contiguous blocks of machine
;       integers, so the C row's flat int64 array becomes a 1000000-element Array of
;       values. The length is set once up front so the stores do not grow the array
;       one element at a time.
; note: out-of-range writes throw IndexError in AutoHotkey v2, so the pre-sizing is
;       what makes the fill loop legal as well as fast.
; note: the total, 499999500000, is past 2^32 but exact in the 64-bit integer type.
; note: the fill and the sum together take about half a second on this machine.
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

arr := []
arr.Length := 1000000

Loop 1000000
    arr[A_Index] := A_Index - 1

total := 0
Loop 1000000
    total += arr[A_Index]

FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(total "`n", "*")
