; task 08 average — expected output: 0.498046875
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 08_average.ahk
; note: AutoHotkey's floating-point type is the 64-bit double, and (i mod 256) / 256.0
;       is the same expression the C row evaluates: "/" is true division and yields a
;       double even when both operands are integers, so it is the operator the task
;       needs and "//" (integer divide) is not.
; note: every reading is a multiple of 1/256 and the running total never passes 5e7, so
;       every partial sum is exact in binary and the answer does not depend on the order
;       of the additions. 100000000 is exactly 390625 cycles of 256, so the total is
;       exactly 49804687.5 and the mean is exactly 0.498046875.
; note: Format("{:.9f}", x) is used rather than the implicit string conversion, which
;       would print the shortest round-trip form. Format uses the C runtime's locale,
;       which on this machine is the invariant one, so the decimal separator is a
;       period; the expected line is exactly nine digits after it.
; note: the full 100000000-iteration run takes about 35 s on this machine; a pass on the same
;       shared host measured 107 s for it.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

total := 0.0

Loop 100000000 {
    i := A_Index - 1
    reading := Mod(i, 256) / 256.0
    total += reading
}

FileAppend(Format("{:.9f}", total / 100000000.0) "`n", "*")
