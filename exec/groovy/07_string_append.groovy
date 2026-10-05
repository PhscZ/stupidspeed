// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: groovy 07_string_append.groovy
// Plain String concatenation, no StringBuilder: java.lang.String is immutable, so
// every append copies the whole string and the task is quadratic by design.

String text = ''
long __t0 = System.nanoTime()
for (int i = 0; i < 250000; i++) {
    text = text + 'x'
}

System.err.println("TIME_MS=" + (System.nanoTime() - __t0) / 1e6)
println text.length()
