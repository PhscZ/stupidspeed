# task 06 char_count — expected output: 10000000
# build: none (interpreted)
# run: raku 06_char_count.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# The 100 MB text is built once with the repetition operator, which allocates it in one go
# rather than a hundred million appends, and then scanned one character at a time.
my $text = "abcdefghij" x 10000000;
my int $count = 0;
loop (my int $i = 0; $i < 100000000; $i++) {
    if $text.substr($i, 1) eq 'h' { $count++ }
}
say $count;
