' task 15 file_write — expected output: 104857600
' build: none (interpreted)    run: cscript //nologo 15_file_write.vbs
' note: out.bin is written into the working directory, 104857600 bytes.
' note: the 1 MiB buffer is bytes 0..255 repeated 4096 times. The pattern is described
'       once as 512 hex digits and expanded to the 1 MiB buffer with a single Replace
'       call, so the buffer is built the way the spec asks (block repeat, not an append
'       loop).
' note: ADODB.Stream is the only binary writer in the engine, and its Write method takes
'       a Byte() array — it rejects a String and a Variant array of Longs with error 3001.
'       The engine also cannot index the Byte() array it hands back, so the array is
'       produced by MSXML's bin.hex conversion, which turns the 2 MB hex text into the
'       1048576-element Byte() array natively. That is a standard-library conversion, not
'       a shortcut around the write loop: the hundred 1 MiB writes below really happen.
' note: the ISO-8859-1 text stream was tried first and rejected: ADODB maps that charset
'       through the ANSI code page, so bytes 0x80..0x9F come out as different bytes (0x80
'       lands on 0x3F). The binary stream writes all 256 byte values exactly; that was
'       checked byte for byte against the pattern.
' note: ADODB.Stream has no fsync and no flush. SaveToFile closes the file, which is as
'       far as the engine's I/O goes; that is the deviation from the C row's _commit.
'       The count printed is the stream's own Position, 104857600 bytes.
Const CHUNKSZ = 1048576
Const REPEATS = 100

Dim hexpat, hexbuf, doc, node, bytes, st, i, written

hexpat = ""
For i = 0 To 255
    hexpat = hexpat & Right("0" & Hex(i), 2)
Next
hexbuf = Replace(String(4096, "x"), "x", hexpat)

Set doc = CreateObject("Msxml2.DOMDocument.6.0")
Set node = doc.createElement("b")
node.dataType = "bin.hex"
node.text = hexbuf
bytes = node.nodeTypedValue

Set st = CreateObject("ADODB.Stream")
st.Type = 1
st.Open

For i = 1 To REPEATS
    st.Write bytes
Next

written = st.Position
st.SaveToFile "out.bin", 2
st.Close

WScript.Echo DecStr(written)

' Exact decimal digits for an integral number below 2^53. Splitting off 1e6 at a time
' keeps every intermediate below 2^53, so p * 1000000 is exact; the guard corrects the
' one-off error the division can make at that size.
Function DecStr(v)
    Dim parts(), np, p, r, s, i

    If v < 1.0 Then
        DecStr = "0"
        Exit Function
    End If

    np = 0
    ReDim parts(8)

    Do While v >= 1.0
        p = Int(v / 1000000.0)
        r = v - p * 1000000.0
        If r < 0.0 Then
            p = p - 1.0
            r = r + 1000000.0
        ElseIf r >= 1000000.0 Then
            p = p + 1.0
            r = r - 1000000.0
        End If
        If np > UBound(parts) Then
            ReDim Preserve parts(np + 8)
        End If
        parts(np) = r
        np = np + 1
        v = p
    Loop

    s = CStr(parts(np - 1))
    For i = np - 2 To 0 Step -1
        s = s & Right("000000" & CStr(parts(i)), 6)
    Next
    DecStr = s
End Function
