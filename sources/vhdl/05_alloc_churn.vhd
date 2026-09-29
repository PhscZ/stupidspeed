-- task 05 alloc_churn - expected output: 1274991808
-- build: ghdl -a --std=08 05_alloc_churn.vhd
-- run: ghdl -r --std=08 t05_alloc_churn
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: VHDL has no garbage collector, so "the slot keeps the new pointer and drops the old
--       one" is an explicit 'deallocate' of the previous occupant before the store -- the same
--       thing the C row does with free(). Without it the 10000000 allocations would grow the
--       process by 640 MB.
-- note: the 64-byte block is a constrained access subtype, 'subtype buf_t is unsigned(511
--       downto 0)', so buf(7 downto 0) is buf[0] and the byte is read back out of the buffer
--       before it is added, exactly as the C row does.
-- note: the total 1274991808 still fits the 32-bit 'integer', so no 64-bit vector is needed.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity t05_alloc_churn is
end entity;

architecture sim of t05_alloc_churn is
  subtype buf_t is unsigned(511 downto 0);
  type buf_ptr is access buf_t;
  type slot_array is array (0 to 255) of buf_ptr;
begin
  process
    variable slots : slot_array := (others => null);
    variable buf   : buf_ptr;
    variable total : integer := 0;
    variable l     : line;
  begin
    for i in 0 to 10000000 - 1 loop
      buf := new buf_t;
      buf(7 downto 0) := to_unsigned(i mod 256, 8);
      total := total + to_integer(buf(7 downto 0));
      if slots(i mod 256) /= null then
        deallocate(slots(i mod 256));
      end if;
      slots(i mod 256) := buf;
    end loop;
    write(l, total);
    writeline(output, l);
    wait;
  end process;
end architecture;
