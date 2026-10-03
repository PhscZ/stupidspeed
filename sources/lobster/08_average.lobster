// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: lobster 08_average.lobster

var total = 0.0

for(100000000) i:
    total += (i % 256) / 256.0

set_print_decimals(9)
print total / 100000000.0
