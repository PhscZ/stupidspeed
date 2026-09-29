; task 06 char_count — expected output: 10000000
; build: none (interpreted)    run: AutoHotkey64.exe /ErrorStdOut 06_char_count.ahk
; note: AutoHotkey has no character type, so the scan is SubStr(text, i, 1) = "h" per
;       character, which allocates a one-character string each time. That is the
;       measured cost. There is no cheaper standard-library idiom that still looks at
;       every character: InStr would search rather than scan, and StrSplit returns one
;       element per character and materialises a million-element array.
; note: the C row only counts 'h' — 'a' and 'e' are skipped — so this does the same.
; note: the text is built by doubling "abcdefghij" 20 times to 10485760 characters,
;       truncating that to the 10000000 characters the pattern repeats into, and then
;       expanding a ten-space source into the 100000000-character text with one
;       StrReplace call. The spec asks for block repetition rather than an append loop,
;       and this is the same construction the VBScript row uses. Ten characters is a
;       multiple of the block, so the expansion leaves the pattern intact.
; note: the whole text is a single UTF-16 string, so its 100000000 characters occupy
;       about 200 MB; that is the row's largest allocation.
; note: the full scan takes about 15 s on this machine, which is the cost of allocating a
;       one-character string and comparing it a hundred million times (a pass on the same
;       shared host measured 51 s).
#Requires AutoHotkey v2.0
#SingleInstance Off
#NoTrayIcon

block := "abcdefghij"
Loop 20
    block .= block
block := SubStr(block, 1, 10000000)
text := StrReplace("          ", " ", block)

count := 0
Loop 100000000
    if (SubStr(text, A_Index, 1) = "h")
        count += 1

FileAppend(count "`n", "*")
