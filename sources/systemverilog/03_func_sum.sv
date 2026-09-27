// task 03 func_sum — expected output: 100000000
// build: iverilog -g2012 -o prog.vvp 03_func_sum_add_one.sv 03_func_sum.sv
// run: vvp prog.vvp
// note: SystemVerilog is a hardware description language, so a 'program' is a testbench
//       module with an initial block and the work is done by the simulator. The measured
//       number is therefore Icarus Verilog's code generator and event loop, not 'the
//       language' -- the same disclosure the GDScript, Dolphin and VHDL rows carry.
// note: -g2012 is required. Plain Verilog has no automatic functions, and without them a
//       recursive function shares one static frame and silently returns wrong answers
//       (fib(10) comes out as -80 instead of 55), so this row is SystemVerilog and not
//       Verilog. That is also why no Verilog row exists.
// note: $finish(0) rather than a bare $finish, because Icarus prints a "$finish called at"
//       diagnostic to stdout for the latter and the task must print one line and nothing else.
// note: $finish(0) rather than a bare $finish, because Icarus prints a "$finish called at"
//       diagnostic to stdout for the latter, and the task must print one line and nothing else.
// note: iverilog is an interpreter over an event queue, so the cost is roughly 5 us per
//       loop iteration. The 100-million-iteration tasks are therefore about 8.5 minutes a
//       run, which the benchmark's no-timeout rule allows; see RUN.md.
// note: the helper is declared at compilation-unit scope in its own file and called
//       directly. A SystemVerilog `package` would be the tidier home for it, but Icarus
//       rejects both `import pkg::*` as a module item and the `pkg::func()` call form.
// note: the helper lives in its own compilation unit, the same two-file shape the Fortran,
//       Tcl, Vala, Common Lisp, Raku and Elixir rows use, so the call crosses a file boundary
//       and the compiler cannot fold it away. Both files go on the iverilog command line,
//       and the helper must come FIRST: with the order reversed Icarus accepts the files and
//       then fails at run time with no diagnostic.
module tb;
  longint value, i;
  initial begin
    value = 0;
    for (i = 0; i < 100000000; i++) value = add_one(value);
    $display("%0d", value);
    $finish(0);
  end
endmodule
