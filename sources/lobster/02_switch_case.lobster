// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: lobster 02_switch_case.lobster

var acc = 0

for(100000000) i:
    switch i % 4:
        case 0: acc += 1
        case 1: acc += i
        case 2: acc += 2 * i
        case 3: acc += 3 * i

print acc
