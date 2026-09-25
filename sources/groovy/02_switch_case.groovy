// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: groovy 02_switch_case.groovy
// A real `switch` on the primitive remainder, so the JVM sees a tableswitch.

long acc = 0

for (long i = 0; i < 100000000L; i++) {
    switch ((int) (i % 4)) {
        case 0: acc += 1; break
        case 1: acc += i; break
        case 2: acc += 2L * i; break
        default: acc += 3L * i; break
    }
}

println acc
