// task 03 func_sum — helper compilation unit.
// The function is declared at compilation-unit scope in its own file so the call crosses a
// compilation-unit boundary, the same reason the Fortran, Tcl, Vala, Common Lisp, Raku and
// Elixir rows split this task. SystemVerilog has no no-inline attribute; separate compilation
// is the only lever the language offers.
//
// A SystemVerilog `package` would be the tidier home for this, but Icarus Verilog rejects both
// `import pkg::*;` as a module item and the fully-qualified `pkg::func()` call form, so the
// function sits at unit scope instead. Both files go on the iverilog command line.

function automatic longint add_one(longint n);
  return n + 1;
endfunction
