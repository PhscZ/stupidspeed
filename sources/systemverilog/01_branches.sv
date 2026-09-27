// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: iverilog -g2012 -o prog.vvp 01_branches.sv
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
module tb;
  longint a, b, c, d, i;
  initial begin
    a = 0; b = 0; c = 0; d = 0;
    for (i = 0; i < 100000000; i++) begin
      if (i % 3 == 0) a++;
      else if (i % 5 == 0) b++;
      else if (i % 7 == 0) c++;
      else d++;
    end
    $display("%0d %0d %0d %0d", a, b, c, d);
    $finish(0);
  end
endmodule
