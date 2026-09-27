// task 11 parallel_sum — expected output: 7500000075000000
// build: iverilog -g2012 -o prog.vvp 11_parallel_sum.sv
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
// note: four concurrent processes, each owning a fixed quarter of task 02's range, exactly as
//       the task asks. They are SystemVerilog processes scheduled by the simulator, so they
//       interleave but never run at once -- there is no second core involved, and Icarus
//       Verilog documents no multi-threaded scheduler. This is the same correct-answer,
//       no-speedup cell the Simula, VHDL and CPython rows occupy, and it is the only cell in
//       this row that is not simply slow.
// note: fork/join is the language's own concurrency construct and the reason an HDL can
//       express this task at all.
module tb;
  longint partial [0:3];

  task automatic worker(input int t);
    longint acc, i;
    begin
      acc = 0;
      for (i = t * 25000000; i < (t + 1) * 25000000; i++) begin
        case (i % 4)
          0: acc += 1;
          1: acc += i;
          2: acc += 2 * i;
          default: acc += 3 * i;
        endcase
      end
      partial[t] = acc;
    end
  endtask

  initial begin
    fork
      worker(0);
      worker(1);
      worker(2);
      worker(3);
    join
    $display("%0d", partial[0] + partial[1] + partial[2] + partial[3]);
    $finish(0);
  end
endmodule
