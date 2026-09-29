-- task 04 array_sum - expected output: 499999500000
-- build: ghdl -a --std=08 04_array_sum.vhd
-- run: ghdl -r --std=08 t04_array_sum
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the elements are 32-bit 'integer', but the sum 499999500000 does not fit one, so the
--       accumulator is unsigned(63 downto 0) and the printing is hand-rolled: to_integer on a
--       64-bit unsigned returns a 32-bit NATURAL in GHDL's numeric_std.
-- note: the 1000000-element array is a process variable, so it lives in GHDL's dynamic stack
--       (heap chunks, --max-stack-alloc default 128 MB), not on the C stack.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity t04_array_sum is
end entity;

architecture sim of t04_array_sum is
  type int_array is array (0 to 999999) of integer;

  function to_decimal (u : unsigned) return string is
    variable v : unsigned(u'range) := u;
    variable q : unsigned(u'range);
    variable s : string(1 to 40);
    variable n : integer := 0;
  begin
    if v = 0 then
      return "0";
    end if;
    while v /= 0 loop
      q := v / 10;
      n := n + 1;
      s(41 - n) := character'val(character'pos('0') + to_integer(v - q * 10));
      v := q;
    end loop;
    return s(41 - n to 40);
  end function;
begin
  process
    variable arr   : int_array;
    variable total : unsigned(63 downto 0) := (others => '0');
    variable l     : line;
  begin
    for i in 0 to 999999 loop
      arr(i) := i;
    end loop;
    for i in 0 to 999999 loop
      total := total + to_unsigned(arr(i), 64);
    end loop;
    write(l, to_decimal(total));
    writeline(output, l);
    wait;
  end process;
end architecture;
