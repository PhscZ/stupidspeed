# task 02 switch_case — expected output: 7500000075000000
# build: none (interpreted)
# run: raku 02_switch_case.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# 7500000075000000 is past 2^31 but well inside int64, so a native int carries it exactly.
my int $acc = 0;
loop (my int $i = 0; $i < 100000000; $i++) {
    given $i % 4 {
        when 0 { $acc += 1 }
        when 1 { $acc += $i }
        when 2 { $acc += 2 * $i }
        default { $acc += 3 * $i }
    }
}
say $acc;
