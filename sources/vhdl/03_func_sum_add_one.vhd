-- task 03 func_sum (helper) - expected output: (no output of its own)
-- build: ghdl -a --std=08 03_func_sum_add_one.vhd 03_func_sum.vhd
-- run: ghdl -r --std=08 t03_func_sum
-- note: the helper lives in its own file as a package, the same two-file shape the Fortran,
--       Modula-2, Tcl, Vala, Common Lisp, Raku and Elixir rows use, so the call crosses a
--       file boundary and the backend cannot fold it away.
-- note: VHDL has no no-inline attribute, so the separate file is the only route. GHDL's mcode
--       backend does no interprocedural inlining at all, so the 100000000 calls are real
--       calls. The MSYS2 -ghdl-llvm package would be the faster alternative but its default
--       -O2 inlines this one-line helper into its single call site, which is exactly what
--       task 03 is designed to prevent -- another reason the row is mcode.
-- note: this file must be analysed BEFORE 03_func_sum.vhd. The caller says
--       'use work.add_one_pkg.all', and GHDL resolves that when it analyses the caller, so
--       with the order reversed the analysis of the caller fails with "unit add_one_pkg not
--       found in library work" -- Icarus-like ordering, as the SystemVerilog row records.
package add_one_pkg is
  function add_one (n : integer) return integer;
end package;

package body add_one_pkg is
  function add_one (n : integer) return integer is
  begin
    return n + 1;
  end function;
end package body;
