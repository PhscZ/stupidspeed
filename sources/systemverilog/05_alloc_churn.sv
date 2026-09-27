// task 05 alloc_churn — expected output: 1274991808
// build: iverilog -g2012 -o prog.vvp 05_alloc_churn.sv
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
// SystemVerilog has no allocator, so the 256 live 64-byte buffers are the 256 rows of a
// two-dimensional array. Writing row v is the allocation and drops whatever that row held
// before, which is the same reachability line the C and Java rows draw. As in the C row only
// byte 0 is written, so this measures the allocation churn and not a 64-byte fill.
module tb;
  byte slots [0:255][0:63];
  longint total, i;
  int v;
  initial begin
    total = 0;
    for (i = 0; i < 10000000; i++) begin
      v = i % 256;
      slots[v][0] = v;
      total += v;
    end
    $display("%0d", total);
    $finish(0);
  end
endmodule
