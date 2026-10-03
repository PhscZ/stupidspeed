# task 07 string_append — expected output: 250000
# build: none (interpreted)
# run: raku 07_string_append.raku
# note: Raku is genuinely imperative -- mutable variables, `for`/`while`/`loop`, and
#       indexable arrays -- so these are the same scalar loops every other row uses, not
#       a functional transcription. map/grep/reduce/hyper operators are deliberately not
#       used in any timed path.
# note: integer arithmetic is arbitrary-precision by default; `int`/`num` native types are
#       used only where the value is known to fit, since native ops are much faster.
# Plain string append 250000 times. NOTE: MoarVM's MVM_string_concatenate has an explicit
# fast path for repeatedly appending the same value -- it detects the case and bumps a
# repetition counter on the string's strand tree instead of copying -- so this runs amortised
# LINEAR here rather than quadratic.
# The cell therefore measures MoarVM's optimised append, not the quadratic copy that task 07
# is designed to measure. That is the runtime's real behaviour for this operation and is
# recorded rather than worked around; forcing a copy would mean writing the row artificially.
my $text = '';
loop (my int $i = 0; $i < 250000; $i++) {
    $text ~= 'x';
}
say $text.chars;
