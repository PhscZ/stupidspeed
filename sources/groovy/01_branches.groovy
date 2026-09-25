// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: groovy 01_branches.groovy
// Groovy's `def` would box into BigDecimal for the counters, so the loop index and
// the four counters are declared `long` and the arithmetic stays on primitives.

long a = 0
long b = 0
long c = 0
long d = 0

for (long i = 0; i < 100000000L; i++) {
    if (i % 3 == 0) {
        a++
    } else if (i % 5 == 0) {
        b++
    } else if (i % 7 == 0) {
        c++
    } else {
        d++
    }
}

println "${a} ${b} ${c} ${d}"
