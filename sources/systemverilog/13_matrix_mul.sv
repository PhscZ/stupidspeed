// task 13 matrix_mul — expected output: 599995000
// build: iverilog -g2012 -o prog.vvp 13_matrix_mul.sv
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
// The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
// column of b. Reordering would be faster, which is the point.
module tb;
  longint a [0:249999];
  longint b [0:249999];
  longint c [0:249999];
  longint total, i, j, r, col, k, sum, idx;
  initial begin
    for (i = 0; i < 500; i++) begin
      for (j = 0; j < 500; j++) begin
        idx = i * 500 + j;
        a[idx] = (i + j) % 7;
        b[idx] = (i * j) % 5;
      end
    end
    for (r = 0; r < 500; r++) begin
      for (col = 0; col < 500; col++) begin
        sum = 0;
        for (k = 0; k < 500; k++) begin
          sum += a[r * 500 + k] * b[k * 500 + col];
        end
        c[r * 500 + col] = sum;
      end
    end
    total = 0;
    for (i = 0; i < 250000; i++) total += c[i];
    $display("%0d", total);
    $finish(0);
  end
endmodule
