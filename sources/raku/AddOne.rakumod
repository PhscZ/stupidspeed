# task 03 func_sum — helper module, the second translation unit.
# A separate file so the call to add-one crosses a module boundary, the same reason the
# Fortran, Tcl, Vala and Common Lisp rows split this task. Raku has no no-inline trait and
# MoarVM does inline, so this is the only lever the language offers.
unit module AddOne;

sub add-one(int $n --> int) is export {
    return $n + 1;
}
