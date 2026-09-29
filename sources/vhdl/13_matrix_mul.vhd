-- task 13 matrix_mul - expected output: 599995000
-- build: ghdl -a --std=08 13_matrix_mul.vhd
-- run: ghdl -r --std=08 t13_matrix_mul
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: plain i, j, k triple loop in that order, as in the C row; the accumulator is a process
--       variable reset at the top of the j loop, because VHDL has no declarations inside a
--       loop body.
-- note: the sum of C is 599995000, which fits the 32-bit 'integer', so no 64-bit vector is
--       needed.
library ieee;
use std.textio.all;

entity t13_matrix_mul is
end entity;

architecture sim of t13_matrix_mul is
  constant N : integer := 500;
  type matrix is array (0 to N - 1, 0 to N - 1) of integer;
begin
  process
    variable a, b, c : matrix;
    variable acc     : integer;
    variable total   : integer := 0;
    variable l       : line;
  begin
    for i in 0 to N - 1 loop
      for j in 0 to N - 1 loop
        a(i, j) := (i + j) mod 7;
        b(i, j) := (i * j) mod 5;
      end loop;
    end loop;

    for i in 0 to N - 1 loop
      for j in 0 to N - 1 loop
        acc := 0;
        for k in 0 to N - 1 loop
          acc := acc + a(i, k) * b(k, j);
        end loop;
        c(i, j) := acc;
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
