-- task 07 string_append - expected output: 1000000
-- build: ghdl -a --std=08 07_string_append.vhd
-- run: ghdl -r --std=08 t07_string_append
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: this is the quadratic cell the task is designed to measure, and VHDL needs no deviation
--       to show it: a string is a fixed-length array, so the standard library's own append --
--       std.textio's write(line, character) -- allocates a string one character longer, copies
--       the old contents and deallocates the old one on every call. 1000000 appends therefore
--       copy about 5*10^11 characters and do 1000000 malloc/free pairs. Measured: 2517 s
--       (42 minutes) for the committed 1000000 appends, which makes this the row's slowest cell.
--       The SystemVerilog row had to document a linear append because it has no immutable string
--       type; VHDL does not.
-- note: the alternative, a pre-sized array plus an index counter, would be the linear cheat and
--       is not written.
library ieee;
use std.textio.all;

entity t07_string_append is
end entity;

architecture sim of t07_string_append is
begin
  process
    variable text : line := null;
    variable l    : line;
  begin
    for i in 1 to 1000000 loop
      write(text, 'x');
    end loop;
    write(l, text.all'length);
    writeline(output, l);
    wait;
  end process;
end architecture;
