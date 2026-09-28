// task 14 file_read — expected output: 2389704704
// build: iverilog -g2012 -o prog.vvp 14_file_read.sv
// run: vvp prog.vvp
// note: SystemVerilog is a hardware description language, so a 'program' is a testbench
//       module with an initial block and the work is done by the simulator. The measured
//       number is therefore Icarus Verilog's code generator and event loop, not 'the
//       language' -- the same disclosure the GDScript, Dolphin and VHDL rows carry.
// note: -g2012 is required. Plain Verilog has no automatic functions, and without them a
//       recursive function shares one static frame and silently returns wrong answers
//       (fib(10) comes out as -80 instead of 55), so this row is SystemVerilog and not
//       Verilog. That is also why no Verilog row exists.
// note: the buffer is named `chunk` because `buf` is a reserved word in Verilog -- it is
//       the buffer gate primitive -- and Icarus rejects it as an identifier.
// note: $finish(0) rather than a bare $finish, because Icarus prints a "$finish called at"
//       diagnostic to stdout for the latter, and the task must print one line and nothing else.
// note: iverilog is an interpreter over an event queue, so the cost is roughly 5 us per
//       loop iteration. The 100-million-iteration tasks are therefore about 8.5 minutes a
//       run, which the benchmark's no-timeout rule allows; see RUN.md.
// note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
//       up; the running total is reduced mod 2^32 after each chunk so it stays inside the 2^53
//       range where a real is exact. The chunk is a 1 MiB byte array and $fread fills it in one
//       call, so this is 90 chunk reads rather than 90 million single-byte reads.
module tb;
  bit [7:0] chunk [0:1048575];
  integer fd, got, i;
  real total;
  initial begin
    total = 0.0;
    fd = $fopen("data.bin", "rb");
    if (fd == 0) begin
      $display("cannot open data.bin");
      $finish(0);
    end
    got = $fread(chunk, fd);
    while (got > 0) begin
      for (i = 0; i < got; i++) total = total + chunk[i];
      total = total % 4294967296.0;
      got = $fread(chunk, fd);
    end
    $fclose(fd);
    $display("%0.0f", total);
    $finish(0);
  end
endmodule
