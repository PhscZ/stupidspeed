-- task 09 fib_recursive - expected output: 102334155
-- build: ghdl -a --std=08 09_fib_recursive.vhd
-- run: ghdl -r --std=08 t09_fib_recursive
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: recursive functions are plain VHDL since VHDL-93; no 'impure' marker is needed because
--       the function has no side effects. fib(40) is about 331 million calls at a maximum depth
--       of 40, and mcode does no inlining, so the calls are real ones.
-- note: 102334155 fits the 32-bit 'integer', so no 64-bit vector is needed.
library ieee;
use std.textio.all;

entity t09_fib_recursive is
end entity;

architecture sim of t09_fib_recursive is
  function fib (n : integer) return integer is
  begin
    if n < 2 then
      return n;
    else
      return fib(n - 1) + fib(n - 2);
    end if;
  end function;
begin
  process
    variable l : line;
  begin
    write(l, fib(40));
    writeline(output, l);
    wait;
  end process;
end architecture;
