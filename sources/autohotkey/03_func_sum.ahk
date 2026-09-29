; task 03 func_sum — expected output: 100000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 03_func_sum.ahk
; note: AddOne lives in its own file, 03_func_sum_add_one.ahk, pulled in by #Include,
;       which is the same cross-file shape the C, Fortran, Modula-2, Tcl and Vala rows
;       use. AutoHotkey is an interpreter with no inlining pass and no no-inline marker
;       to offer, so the call is a real interpreted call a hundred million times either
;       way; the file split is kept for the row convention and the header of the helper
;       records that there is nothing to defeat.
; note: #Include is a load-time textual merge, not a compiler: a script behaves as
;       though the included file's contents were pasted in at the #Include line.
; note: value stays inside the small range the whole way (it ends at 100000000).
; note: the full run takes about 35 s on this machine, which is the 100000000 interpreted
;       calls and nothing else (a pass on the same shared host measured 102 s).
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

#Include "03_func_sum_add_one.ahk"

value := 0

Loop 100000000
    value := AddOne(value)

FileAppend(value "`n", "*")
