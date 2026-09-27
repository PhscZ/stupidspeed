// task 06 char_count — expected output: 10000000
// build: iverilog -g2012 -o prog.vvp 06_char_count.sv
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
// note: the ten-character cycle is a ten-element byte array rather than a string literal,
//       because Icarus does not support indexing a string literal ("abc"[i]).
// note: the 100 MB text is a fixed 100-million-byte array, which is what a hardware language
//       has instead of a growable string. It is filled from the ten-character cycle and then
//       scanned one byte at a time, so both passes are 100 million steps and the cell costs
//       roughly twice the 100-million-iteration tasks.
module tb;
  bit [7:0] text [0:99999999];
  bit [7:0] pat [0:9];
  longint count, i;
  initial begin
    pat[0] = "a"; pat[1] = "b"; pat[2] = "c"; pat[3] = "d"; pat[4] = "e";
    pat[5] = "f"; pat[6] = "g"; pat[7] = "h"; pat[8] = "i"; pat[9] = "j";
    for (i = 0; i < 100000000; i++) text[i] = pat[i % 10];
    count = 0;
    for (i = 0; i < 100000000; i++) if (text[i] == "h") count++;
    $display("%0d", count);
    $finish(0);
  end
endmodule
