# task 03 func_sum — expected output: 100000000
# build: none (interpreted)    run: nu main.nu
#
# Nushell is an AST interpreter, not a compiler, so there is nothing that inlines the
# call away: `add_one` really is entered 100000000 times. There is no no-inline
# attribute in the language, and none is needed.

def add_one [n: int] {
    $n + 1
}

mut value = 0

for i in 0..99999999 {
    $value = (add_one $value)
}

print $value
