-- task 01 branches - expected output: 33333334 13333333 7619048 45714285
-- build: ghdl -a --std=08 01_branches.vhd
-- run: ghdl -r --std=08 t01_branches
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: all four counters stay inside the 32-bit 'integer' (45714285 is the largest), so this
--       task needs no 64-bit vector. GHDL's integer is 32 bits and overflow is a hard runtime
--       error, not a silent wrap.
library ieee;
use std.textio.all;

entity t01_branches is
end entity;

architecture sim of t01_branches is
begin
  process
    variable a, b, c, d : integer := 0;
    variable l : line;
  begin
    for i in 0 to 100000000 - 1 loop
      if i mod 3 = 0 then
        a := a + 1;
      elsif i mod 5 = 0 then
        b := b + 1;
      elsif i mod 7 = 0 then
        c := c + 1;
      else
        d := d + 1;
      end if;
    end loop;
    write(l, a);
    write(l, string'(" "));
    write(l, b);
    write(l, string'(" "));
    write(l, c);
    write(l, string'(" "));
    write(l, d);
    writeline(output, l);
    wait;
  end process;
end architecture;
