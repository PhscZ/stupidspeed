// task 12 matrix_add — expected output: 999000000
// build: iverilog -g2012 -o prog.vvp 12_matrix_add.sv
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
// Three flat 1000x1000 longint arrays, row-major, filled and added with plain index
// arithmetic. The total fits comfortably in 64 bits.
module tb;
  longint a [0:999999];
  longint b [0:999999];
  longint c [0:999999];
  longint total, i, j, p, q, idx;
  initial begin
    for (i = 0; i < 1000; i++) begin
      for (j = 0; j < 1000; j++) begin
        idx = i * 1000 + j;
        a[idx] = i + j;
        b[idx] = i - j;
      end
    end
    for (p = 0; p < 1000; p++) begin
      for (q = 0; q < 1000; q++) begin
        idx = p * 1000 + q;
        c[idx] = a[idx] + b[idx];
      end
    end
    total = 0;
    for (i = 0; i < 1000000; i++) total += c[i];
    $display("%0d", total);
    $finish(0);
  end
endmodule
