' task 07 string_append -- expected output: 1000000
' build: fbc -O 2 -x prog.exe 07_string_append.bas    run: ./prog
dim text as string = ""
dim i as longint

for i = 1 to 1000000
    text &= "x"
next

print str(len(text))
