# task 06 char_count — expected output: 10000000
# build: none (interpreted)    run: nu 06_char_count.nu
#
# nu has no `str repeat`, so the 100 MB text is built once by joining a list of
# 10000000 copies of the 10-character block — one bulk operation, never an append per
# character. The scan then takes one `str substring` per character, which is very slow
# in nu: this task is expected to hit the 300 s timeout.

let text = (1..10000000 | each {|_| 'abcdefghij'} | str join)

mut count = 0

for i in 0..99999999 {
    if ($text | str substring $i..$i) == 'h' {
        $count = $count + 1
    }
}

print $count
