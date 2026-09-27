' task 07 string_append — expected output: 1000000
' build: none (interpreted)    run: cscript //nologo 07_string_append.vbs
' note: VBScript strings are immutable and copy on every concatenation, so this loop is
'       quadratic exactly as the spec intends: text = text & "x" builds a fresh string of
'       length i every iteration, copying i characters. There is no StringBuilder in the
'       standard library and no growable string in the engine.
' note: the count is left at a million. At a million the loop copies about 5 * 10^11
'       characters in total, which is what the measured time below reflects.
' note: Len(text) is used as the printed value, so the loop cannot be deleted; an
'       interpreted engine would not delete it anyway.
Dim text, i

text = ""

For i = 1 To 1000000
    text = text & "x"
Next

WScript.Echo Len(text)
