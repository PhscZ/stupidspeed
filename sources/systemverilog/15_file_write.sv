// task 15 file_write — expected output: 94371840
// build: iverilog -g2012 -o prog.vvp 15_file_write.sv
// run: vvp prog.vvp
// note: SystemVerilog is a hardware description language, so a 'program' is a testbench
//       module with an initial block and the work is done by the simulator. The measured
//       number is therefore Icarus Verilog's code generator and event loop, not 'the
//       language' -- the same disclosure the GDScript, Dolphin and VHDL rows carry.
// note: -g2012 is required. Plain Verilog has no automatic functions, and without them a
//       recursive function shares one static frame and silently returns wrong answers
//       (fib(10) comes out as -80 instead of 55), so this row is SystemVerilog and not
//       Verilog. That is also why no Verilog row exists.
// note: the buffer is written one byte at a time because Icarus's $fwrite does not accept a
//       memory (it reports "$fwrite does not support argument type (vpiMemory)"), and
//       SystemVerilog has no way to hand a whole array to a system task. That is 94 million
//       $fwrite calls for the 90 MiB, measured at about 12.5 minutes a run.
// note: the buffer is named `chunk` because `buf` is a reserved word in Verilog -- it is
//       the buffer gate primitive -- and Icarus rejects it as an identifier.
// note: $finish(0) rather than a bare $finish, because Icarus prints a "$finish called at"
//       diagnostic to stdout for the latter, and the task must print one line and nothing else.
// note: iverilog is an interpreter over an event queue, so the cost is roughly 5 us per
//       loop iteration. The 100-million-iteration tasks are therefore about 8.5 minutes a
//       run, which the benchmark's no-timeout rule allows; see RUN.md.
// note: the 1 MiB buffer holds the bytes 0..255 repeated 4096 times and is written 90 times,
//       then flushed and closed. SystemVerilog exposes no fsync, so the deviation is flush plus
//       close -- the same one the Tcl, D, Julia, Nim, Dart, Pascal, COBOL, Dolphin, Common Lisp,
//       Raku, Erlang and Elixir rows note.
module tb;
  bit [7:0] chunk [0:1048575];
  integer fd, i, n;
  initial begin
    for (i = 0; i < 1048576; i++) chunk[i] = i % 256;
    fd = $fopen("out.bin", "wb");
    if (fd == 0) begin
      $display("cannot open out.bin");
      $finish(0);
    end
    for (n = 0; n < 90; n++) begin
      for (i = 0; i < 1048576; i++) $fwrite(fd, "%c", chunk[i]);
    end
    $fclose(fd);
    $display("%0d", 90 * 1048576);
    $finish(0);
  end
endmodule
