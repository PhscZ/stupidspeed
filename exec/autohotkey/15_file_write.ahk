; task 15 file_write — expected output: 52428800
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 15_file_write.ahk
; note: out.bin is written into the working directory, 52428800 bytes.
; note: the 1 MiB buffer is bytes 0..255 repeated 4096 times, filled with NumPut of a
;       UChar per byte, which is the byte-level equivalent of the C row's buf[i] = i %
;       256 store.
; note: the file is opened with the explicit UTF-8-RAW encoding because creating a file
;       with a plain UTF-8 or UTF-16 encoding writes a byte order mark; RawWrite does no
;       translation, so the 50 MiB are byte-exact.
; note: the flush is a real fsync: AutoHotkey's File has no flush method, so the Win32
;       FlushFileBuffers is called on the file's OS handle through the built-in DllCall,
;       the same class of call the Assembly, Oberon-07 and Component Pascal rows already
;       make. Reading File.Handle commits AutoHotkey's own buffered writes before it
;       returns the handle, and Close then releases it. The C row's _commit is the same
;       operation.
; note: the count printed is the sum of RawWrite's return values, so it is the number of
;       bytes actually written, not a constant.
; note: the 1048576-byte fill and the 50 writes take about 0.6 s in total on this machine.
;       The file on disk was checked afterwards: 52428800 bytes, bytes 0..255 repeating,
;       and no byte order mark.
; timing: A_TickCount is the interpreter's own millisecond clock (GetTickCount, so about
;       15 ms resolution); TIME_MS is written to stderr with FileAppend(..., "**") and
;       stdout is unchanged.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

t0 := A_TickCount

CHUNK := 1048576
REPEATS := 50

buf := Buffer(CHUNK)
i := 0
while (i < CHUNK) {
    NumPut("UChar", Mod(i, 256), buf, i)
    i += 1
}

f := FileOpen("out.bin", "w", "UTF-8-RAW")

written := 0
Loop REPEATS
    written += f.RawWrite(buf)

DllCall("FlushFileBuffers", "Ptr", f.Handle)
f.Close()

FileAppend("TIME_MS=" (A_TickCount - t0) "`n", "**")
FileAppend(written "`n", "*")
