' task 14 file_read — expected output: 484442112
' build: none (interpreted)    run: cscript //nologo 14_file_read.vbs
' note: data.bin must be in the working directory: 104857600 bytes, the bytes 0 through
'       255 repeating.
' note: VBScript has no byte type and cannot index the Byte() array ADODB.Stream.Read
'       returns — the engine answers a type mismatch for element access and refuses
'       For Each with "object is not a collection" — so the file is read through the
'       same stream in text mode with the single-byte ISO-8859-1 charset, where one
'       character is one byte, and Asc(Mid(chunk, i, 1)) reads each byte back. That
'       decodes and re-encodes through the machine's ANSI code page, so the byte values
'       round-trip exactly, which is what the sum checks. Measured cost, end to end on
'       the 100 MiB fixture: about 1.1 us per byte, 120 s for the whole file.
' note: chunks are 1 MiB, the same size the C row reads, and the loop stops when
'       ReadText returns an empty string.
' note: the C row accumulates in uint64 and takes total % 2^32 at the end. VBScript's
'       Mod is Long-only and overflows on a total this size, so the remainder is taken
'       as total - Int(total / 4294967296) * 4294967296, which is the same operation and
'       is exact in a Double because every intermediate stays below 2^53.
' note: the running total is a Double from the start. The engine would promote it after
'       2^31 anyway, and 13369344000 is exact either way.
Const CHUNKSZ = 1048576

Dim st, chunk, total, i, n

Set st = CreateObject("ADODB.Stream")
st.Type = 2
st.Charset = "ISO-8859-1"
st.Open
st.LoadFromFile "data.bin"

total = 0.0

Do
    chunk = st.ReadText(CHUNKSZ)
    n = Len(chunk)
    If n = 0 Then Exit Do
    For i = 1 To n
        total = total + Asc(Mid(chunk, i, 1))
    Next
Loop

st.Close

WScript.Echo DecStr(total - Int(total / 4294967296.0) * 4294967296.0)

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
