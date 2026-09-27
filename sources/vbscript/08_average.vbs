' task 08 average — expected output: 0.498046875
' build: none (interpreted)    run: cscript //nologo 08_average.vbs
' note: Double is VBScript's only floating-point type, and (i Mod 256) / 256.0 is the
'       same expression the C row evaluates. Every reading is a multiple of 1/256 and
'       the running total never passes 5 * 10^7, so every partial sum is exact in binary
'       and the answer does not depend on the order of the additions.
' note: CStr uses the machine's decimal separator, which is a comma in this locale, and
'       CStr(0.498046875) would print "0,498046875" here. The value is therefore
'       formatted by hand: the integer part, a period, and the fraction to nine places.
'       The fraction is scaled by 1e9 and rounded with Int(x + 0.5) — Int truncates
'       towards zero, so a half lands on the larger digit, which is the behaviour the C
'       row's printf gets. CLng would not do: it rounds halves to even, and 0.498046875
'       scaled is exactly 498046875.5.
Dim total, i, reading

total = 0.0

For i = 0 To 99999999
    reading = (i Mod 256) / 256.0
    total = total + reading
Next

WScript.Echo Fixed9(total / 100000000.0)

' Nine decimal places, assembled by hand because the engine's locale is not C.
' Int(x + 0.5) rounds a half up; CLng would round it to even, and the fraction here is
' exactly 498046875.5, so CLng would print 0.498046876 instead of 0.498046875.
Function Fixed9(v)
    Dim ip, fp, f

    ip = Int(v)
    fp = v - ip
    f = Int(fp * 1000000000.0 + 0.5)
    If f >= 1000000000 Then
        ip = ip + 1
        f = 0
    End If
    Fixed9 = CStr(ip) & "." & Right("000000000" & CStr(f), 9)
End Function
