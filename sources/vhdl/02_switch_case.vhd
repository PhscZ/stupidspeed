-- task 02 switch_case - expected output: 7500000075000000
-- build: ghdl -a --std=08 02_switch_case.vhd
-- run: ghdl -r --std=08 t02_switch_case
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the answer 7500000075000000 does not fit GHDL's 32-bit 'integer' and VHDL has no
--       64-bit integer type at all (integer_64 is an open VHDL-2019 feature request), so the
--       accumulator is ieee.numeric_std.unsigned(63 downto 0). Its 'to_integer' returns a
--       32-bit NATURAL, so the decimal printing is hand-rolled from repeated division by 10.
-- note: this is the row's most expensive cell and the price is the 64-bit vector arithmetic:
--       the mcode backend does no optimisation and GHDL's numeric_std is ordinary VHDL, so a
--       64-bit add costs about 17 us where a 32-bit one costs about 9 ns. Measured: 2430 s
--       (40.5 minutes) for the committed 100000000 iterations, against 1.2 s for task 01's
--       32-bit counters over the same count. See RUN.md.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity t02_switch_case is
end entity;

architecture sim of t02_switch_case is
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
    variable acc : unsigned(63 downto 0) := (others => '0');
    variable l   : line;
  begin
    for i in 0 to 100000000 - 1 loop
      case i mod 4 is
        when 0 => acc := acc + 1;
        when 1 => acc := acc + to_unsigned(i, 64);
        when 2 => acc := acc + to_unsigned(2 * i, 64);
        when others => acc := acc + to_unsigned(3 * i, 64);
      end case;
    end loop;
    write(l, to_decimal(acc));
    writeline(output, l);
    wait;
  end process;
end architecture;
