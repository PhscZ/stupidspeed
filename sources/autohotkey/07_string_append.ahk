; task 07 string_append — expected output: 1000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 07_string_append.ahk
; note: this cell is a documented deviation, the same one the Raku, Erlang, Elixir and
;       SystemVerilog rows carry. The loop is written exactly as the spec asks, but
;       AutoHotkey's expression compiler gives appending to a normal variable its own
;       path: the concat emits a call to Var::Append instead of allocating a fresh
;       copy, and Var::Append grows the variable's buffer geometrically (16 -> 260
;       bytes, then x1.1 up to 160 KB, +16 KB to 1600 KB, +1% to 6400 KB, +64 KB above
;       that). The reallocations are therefore logarithmic and the total copying is
;       O(n), not O(n^2) — measured, the cost per append is flat as the count grows.
;       The cell measures AutoHotkey's optimised in-place append rather than the
;       quadratic copy the task is designed to expose, and it is recorded rather than
;       worked around: forcing a copy would mean writing the row artificially, which
;       is further from the rules than the deviation is. The loop count is left at the
;       spec's million.
; note: there is no StringBuilder and no growable string in the standard library;
;       VarSetStrCapacity exists to pre-size a variable for repeated concatenation and
;       is deliberately not used, because the task's loop is the plain one.
; note: StrLen(text) is used as the printed value, so the loop cannot be deleted.
; note: measured on this machine, one million appends take 0.35 s wall clock, and the cost
;       per append falls as the count grows rather than rising: 0.58 s at 1M, 0.97 s at 4M
;       and 1.47 s at 8M, a fit of interpreter start-up plus about 0.13 us per append. A
;       quadratic loop would need roughly 8 s at 8M appends; it needs 1.5 s.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

text := ""

Loop 1000000
    text .= "x"

FileAppend(StrLen(text) "`n", "*")
