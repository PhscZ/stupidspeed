// task 07 string_append — expected output: 1000000
// build: none (interpreted)    run: groovy 07_string_append.groovy
// Plain String concatenation, no StringBuilder: java.lang.String is immutable, so
// every append copies the whole string and the task is quadratic by design.

String text = ''
for (int i = 0; i < 1000000; i++) {
    text = text + 'x'
}

println text.length()
