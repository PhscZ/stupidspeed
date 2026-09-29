; task 14 file_read — expected output: 2389704704
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 14_file_read.ahk
; note: data.bin must be in the working directory: 52428800 bytes, the bytes 0 through
;       255 repeating.
; note: the bytes must not come out of a string. AutoHotkey's native string is UTF-16
;       and FileRead converts bytes to text by default, which changes binary data; the
;       documented binary route is FileOpen with "r" plus RawRead into a Buffer, and
;       NumGet reads one byte back out of it. The sum loop is therefore one byte at a
;       time, exactly as the C row's inner loop is.
; note: the read is chunked at 1 MiB, the same chunk size the C row uses; the spec's
;       "one byte at a time" is about the summation, not about the read call. Reading
;       the whole 50 MiB file into one Buffer would also work and is not used, to keep
;       the read shape identical to C's.
; note: the total reaches 6684672000, past 2^32 but exact in the 64-bit integer type,
;       and Mod(total, 4294967296) is the same remainder the C row takes with %.
; note: the full run takes about 15 s on this machine, about 0.28 us per byte; the read is
;       chunked, so nearly all of that is the per-byte NumGet loop.
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

CHUNK := 1048576

f := FileOpen("data.bin", "r")
buf := Buffer(CHUNK)

total := 0
while ((got := f.RawRead(buf)) > 0) {
    i := 0
    while (i < got) {
        total += NumGet(buf, i, "UChar")
        i += 1
    }
}

f.Close()

FileAppend(Mod(total, 4294967296) "`n", "*")
