' task 02 switch_case -- expected output: 7500000075000000
' build: fbc -O 2 -x 02_switch_case.bas    run: ./02_switch_case.exe
dim acc as longint = 0
dim i as longint

for i = 0 to 99999999
    select case (i mod 4)
        case 0
            acc += 1
        case 1
            acc += i
        case 2
            acc += 2 * i
        case 3
            acc += 3 * i
    end select
next

print str(acc)
