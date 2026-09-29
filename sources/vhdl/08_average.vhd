-- task 08 average - expected output: 0.498046875
-- build: ghdl -a --std=08 08_average.vhd
-- run: ghdl -r --std=08 t08_average
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: textio's real format has to be pinned down or the line comes out wrong. With the default
--       DIGITS = 0 GHDL prints a normalised mantissa and an exponent, so the call passes
--       digits => 9. The value is exact in binary and exactly nine fractional digits long
--       (0.498046875 = 255/512), so nine digits print it with no rounding to hide.
library ieee;
use std.textio.all;

entity t08_average is
end entity;

architecture sim of t08_average is
begin
  process
    variable total   : real := 0.0;
    variable reading : real;
    variable l       : line;
  begin
    for i in 0 to 100000000 - 1 loop
      reading := real(i mod 256) / 256.0;
      total := total + reading;
    end loop;
    write(l, total / 100000000.0, digits => 9);
    writeline(output, l);
    wait;
  end process;
end architecture;
