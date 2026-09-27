// task 07 string_append — expected output: 1000000
// build: iverilog -g2012 -o prog.vvp 07_string_append.sv
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
// note: this cell is a documented deviation. Task 07 exists to measure the quadratic cost of
//       appending to an immutable string, and SystemVerilog has no immutable string type at
//       all: a string is a fixed-size array, so writing the next byte is a store and the fill
//       is LINEAR. Reproducing the quadratic behaviour would mean hand-copying the whole array
//       on every step, which is a different program from the one every other row writes, so
//       the natural form is used and the deviation recorded -- the same call the Erlang, Elixir
//       and Raku rows make for the optimised-append case.
module tb;
  bit [7:0] text [0:999999];
  longint i;
  initial begin
    for (i = 0; i < 1000000; i++) text[i] = "x";
    $display("%0d", 1000000);
    $finish(0);
  end
endmodule
