' task 01 branches -- expected output: 33333334 13333333 7619048 45714285
' build: fbc -O 2 -x 01_branches.bas    run: ./01_branches.exe
dim a as longint = 0
dim b as longint = 0
dim c as longint = 0
dim d as longint = 0
dim i as longint

for i = 0 to 99999999
    if (i mod 3) = 0 then
        a += 1
    elseif (i mod 5) = 0 then
        b += 1
    elseif (i mod 7) = 0 then
        c += 1
    else
        d += 1
    end if
next

print str(a) & " " & str(b) & " " & str(c) & " " & str(d)
