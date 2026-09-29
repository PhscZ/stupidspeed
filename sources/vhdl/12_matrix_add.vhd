-- task 12 matrix_add - expected output: 999000000
-- build: ghdl -a --std=08 12_matrix_add.vhd
-- run: ghdl -r --std=08 t12_matrix_add
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the matrices are VHDL two-dimensional arrays, 'array (0 to 999, 0 to 999) of integer',
--       so A(i, j) is A[i][j]. Three of them are 12 MB, which GHDL puts in its dynamic stack
--       (heap chunks), not on the C stack.
-- note: the sum of C is 999000000, which fits the 32-bit 'integer', so no 64-bit vector is
--       needed.
library ieee;
use std.textio.all;

entity t12_matrix_add is
end entity;

architecture sim of t12_matrix_add is
  constant N : integer := 1000;
  type matrix is array (0 to N - 1, 0 to N - 1) of integer;
begin
  process
    variable a, b, c : matrix;
    variable total   : integer := 0;
    variable l       : line;
  begin
    for i in 0 to N - 1 loop
      for j in 0 to N - 1 loop
        a(i, j) := i + j;
        b(i, j) := i - j;
      end loop;
    end loop;

    for i in 0 to N - 1 loop
      for j in 0 to N - 1 loop
        c(i, j) := a(i, j) + b(i, j);
      end loop;
    end loop;

    for i in 0 to N - 1 loop
      for j in 0 to N - 1 loop
        total := total + c(i, j);
      end loop;
    end loop;

    write(l, total);
    writeline(output, l);
    wait;
  end process;
end architecture;
