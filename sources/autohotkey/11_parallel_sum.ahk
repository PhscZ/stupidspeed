; task 11 parallel_sum — expected output: 7500000075000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 11_parallel_sum.ahk
; note: AutoHotkey has no threads. Its "threads" are hotkey/timer/menu/GUI event flows
;       inside one OS thread, and there is no thread library and no way to declare one,
;       so this is four child processes rather than four threads, the same route the
;       VBScript, R and COBOL rows take. The benchmark accepts it as "pass, but with
;       processes rather than threads", and on Windows it is real parallelism across
;       four cores.
; note: this one file is both parent and child. With an argument it computes one
;       quarter and prints the partial sum; with none it starts four copies of itself
;       through WScript.Shell.Exec, each given a worker index, and adds the four
;       partials it reads back. Reading a child's StdOut blocks until that child closes
;       it, which is the join.
; note: A_AhkPath is the full path of the executable actually running the script, so
;       the parent can be started from any working directory and does not need the
;       interpreter on PATH; A_ScriptFullPath is the file the child is to run.
; note: #SingleInstance Off is mandatory rather than cosmetic. Left unset, a script
;       behaves as though set to Prompt and instances are identified by the script's
;       main-window title, so four children of the same script would prompt for or
;       replace each other.
; note: each worker owns a fixed quarter, so which one finishes first cannot change the
;       answer. The four partials are 468750018750000, 1406250018750000, 2343750018750000
;       and 3281250018750000, and their total, 7500000075000000, is well inside the
;       64-bit integer range.
; note: the child's stdout comes back as a string and is converted with "+ 0", the
;       numeric conversion an arithmetic context performs. The trailing newline has to
;       be trimmed off first: AutoHotkey v2 rejects a numeric string that still has a
;       newline in it with "Expected a Number but got a String" rather than trimming it,
;       so "raw + 0" alone would raise. Integer() is not an alternative either — in v2
;       it takes a number or a numeric literal, not a run-time string.
; note: the parent prints through the same FileAppend(result "`n", "*") as every other
;       task; the children's stdout is a pipe, which is the one case AutoHotkey delivers
;       stdout to without a console.
; note: the four quarters together take about 13 s of wall clock on this machine, and the same
;       total work run serially as task 02 measured 37 s in the same window, so the four child
;       processes are worth a little over two times on a shared host. A pass on the same host
;       measured 52 s for the four and 180 s for task 02.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

if (A_Args.Length = 1) {
    ; child: compute one quarter and print it
    t := A_Args[1] + 0
    acc := 0
    i := t * 25000000
    hi := i + 25000000
    while (i < hi) {
        Switch Mod(i, 4) {
            Case 0: acc += 1
            Case 1: acc += i
            Case 2: acc += 2 * i
            Case 3: acc += 3 * i
        }
        i += 1
    }
    FileAppend(acc "`n", "*")
    ExitApp
}

kids := []
Loop 4
    kids.Push(ComObject("WScript.Shell").Exec('"' A_AhkPath '" /ErrorStdOut "' A_ScriptFullPath '" ' (A_Index - 1)))

total := 0
Loop 4 {
    ; the child's stdout arrives as a string, and its trailing newline has to go before
    ; it can be converted: AutoHotkey v2 rejects a numeric string that still has the
    ; newline in it ("Expected a Number but got a String"), it does not trim it.
    raw := RTrim(kids[A_Index].StdOut.ReadAll(), "`r`n")
    total += raw + 0
}

FileAppend(total "`n", "*")
