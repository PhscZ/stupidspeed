; task 05 alloc_churn — expected output: 1274991808
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 05_alloc_churn.ahk
; note: AutoHotkey has no free and no malloc. The allocation primitive is Buffer(64),
;       which allocates a fresh 64-byte block outside the script's own heap and is
;       released by the collector when the last reference to it goes away, and
;       NumPut/NumGet are how the C row's buf[0] is written and read back.
; note: storing into slots keeps the buffer reachable and drops the one it replaces,
;       which is what makes the replaced block garbage; it is the same thing the C
;       row's free(slots[slot]) does by hand. Without the store the loop would be dead
;       code.
; note: AHK arrays are 1-based and an out-of-range write throws, so the slot index is
;       Mod(i, 256) + 1; slots is pre-sized to 256 for the same reason.
; note: the total, 1274991808, stays inside the 32-bit range, so this is exact integer
;       arithmetic from start to finish.
; note: the full run takes about 9 s on this machine, so a Buffer(64) allocation plus the
;       NumPut/NumGet pair costs a little under a microsecond.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

slots := []
slots.Length := 256

total := 0

Loop 10000000 {
    i := A_Index - 1
    buf := Buffer(64)
    NumPut("UChar", Mod(i, 256), buf, 0)
    total += NumGet(buf, 0, "UChar")
    slots[Mod(i, 256) + 1] := buf
}

FileAppend(total "`n", "*")
