// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: lobster 01_branches.lobster

var a = 0
var b = 0
var c = 0
var d = 0

for(100000000) i:
    if i % 3 == 0:
        a += 1
    elif i % 5 == 0:
        b += 1
    elif i % 7 == 0:
        c += 1
    else:
        d += 1

print "{a} {b} {c} {d}"
