// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: groovy 08_average.groovy
// `double` keeps the loop in primitive floating point; Groovy's `def` would promote
// this to BigDecimal and change both the cost and the printed digits.

double total = 0.0

for (int i = 0; i < 100000000; i++) {
    double reading = (i % 256) / 256.0d
    total += reading
}

println(total / 100000000.0d)
