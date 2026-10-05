; task 09 fib_recursive — expected output: 102334155
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 09_fib_recursive.ahk
; note: AutoHotkey is interpreted, so the recursion really happens — there is no
;       compiler to turn the double call into a loop, and no marker is needed to stop
;       one. Function definitions are known before the script's first line runs, so the
;       call below the definition is the same call as any other.
; note: fib(40) is about 331 million calls. The result, 102334155, fits in the 64-bit
;       integer type, so the arithmetic never leaves exact integer range.
; note: the full run takes about 249 s on this machine, a little over four minutes, for about
;       331 million calls (a pass on the same shared host measured 710 s).
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

res := Fib(40)
FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(res "`n", "*")

Fib(n) {
    if (n < 2)
        return n
    return Fib(n - 1) + Fib(n - 2)
}
