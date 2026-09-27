// task 09 fib_recursive — expected output: 102334155
// build: iverilog -g2012 -o prog.vvp 09_fib_recursive.sv
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
//       diagnostic to stdout for the latter, and the task must print one line and nothing else.
// note: iverilog is an interpreter over an event queue, so the cost is roughly 5 us per
//       loop iteration. The 100-million-iteration tasks are therefore about 8.5 minutes a
//       run, which the benchmark's no-timeout rule allows; see RUN.md.
// Naive fib(40): about 331 million calls, so this measures the call path itself. `automatic`
// is what makes the recursion correct -- without it every call shares one frame and the
// answer is wrong, which is the reason this row is SystemVerilog rather than Verilog.
module tb;
  function automatic longint fib(longint n);
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
  endfunction
  initial begin
    $display("%0d", fib(40));
    $finish(0);
  end
endmodule
