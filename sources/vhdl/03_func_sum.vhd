-- task 03 func_sum - expected output: 100000000
-- build: ghdl -a --std=08 03_func_sum_add_one.vhd 03_func_sum.vhd
-- run: ghdl -r --std=08 t03_func_sum
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: add_one lives in its own file as the package add_one_pkg, so the call is a real
--       cross-file call. VHDL has no no-inline attribute; the separate file is the only route,
--       and GHDL's mcode backend does no interprocedural inlining. The helper file must be
--       analysed FIRST, exactly as in the SystemVerilog row.
library ieee;
use std.textio.all;
use work.add_one_pkg.all;

entity t03_func_sum is
end entity;

architecture sim of t03_func_sum is
begin
  process
    variable value : integer := 0;
    variable l : line;
  begin
    for i in 0 to 100000000 - 1 loop
      value := add_one(value);
    end loop;
    write(l, value);
    writeline(output, l);
    wait;
  end process;
end architecture;
