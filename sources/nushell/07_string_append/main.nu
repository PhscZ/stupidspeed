# task 07 string_append — expected output: 1000000
# build: none (interpreted)    run: nu main.nu
#
# nu strings are immutable values, so `$text + 'x'` builds a new string and copies the
# whole thing every time. That quadratic copy is exactly what this task measures.

mut text = ''

for i in 0..999999 {
    $text = $text + 'x'
}

print ($text | str length)
