-- task 11 parallel_sum - expected output: 7500000075000000
-- build: ghdl -a --std=08 11_parallel_sum.vhd
-- run: ghdl -r --std=08 t11_parallel_sum
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: four concurrent processes, each owning a fixed quarter of task 02's range, exactly as
--       the task asks. They are VHDL processes -- a process is a concurrent statement, and the
--       language's simulation cycle is defined to execute the resumed processes in an arbitrary
--       order -- so this is the language's own concurrency construct and the reason an HDL can
--       express this task at all, the same as SystemVerilog's fork/join.
-- note: the workers interleave but never run at once. Every shipped GHDL build schedules them
--       on one OS thread: src/grt/grt-threads.ads is 'package Grt.Threads renames
--       Grt.Unithread' and grt-unithread.adb's Run_Parallel just calls the process runner once,
--       on the calling thread. The kernel takes the sequential path when Nbr_Threads = 1, and
--       its own comment says "there is no real locks, since the kernel is single threading".
--       --threads=N is parsed but dead: its help line is commented out, GHDL's author calls it
--       "dead code of an aborted effort", and the pthread process-parallel kernel is behind a
--       commented-out GRT_USE_PTHREADS build switch that is pthread (Unix) only. So this cell
--       is correct-answer-no-speedup, the same category Simula, CPython and SystemVerilog's
--       fork/join occupy, and it is not a second core. Measured against task 02, which does the
--       identical 100000000 iterations of the identical switch: 2422 s here versus 2430 s
--       there, a ratio of 1.003 -- noise. The four workers really do interleave and the answer
--       is right; the clock simply does not move.
-- note: each worker owns its own element of the 'partial' signal array, so the result does not
--       depend on the order the processes are resumed in. The collector is a fifth process
--       that waits for all four ('wait until done = "1111"') and only then reads the partials.
-- note: the total is the same 7500000075000000 as task 02, so it needs the same
--       unsigned(63 downto 0) accumulator and the same hand-rolled decimal printer.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity t11_parallel_sum is
end entity;

architecture sim of t11_parallel_sum is
  type partial_array is array (0 to 3) of unsigned(63 downto 0);

  signal partial : partial_array := (others => (others => '0'));
  signal done    : bit_vector(0 to 3) := (others => '0');

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
  gen_workers : for t in 0 to 3 generate
    worker : process
      variable acc : unsigned(63 downto 0) := (others => '0');
    begin
      for i in t * 25000000 to (t + 1) * 25000000 - 1 loop
        case i mod 4 is
          when 0 => acc := acc + 1;
          when 1 => acc := acc + to_unsigned(i, 64);
          when 2 => acc := acc + to_unsigned(2 * i, 64);
          when others => acc := acc + to_unsigned(3 * i, 64);
        end case;
      end loop;
      partial(t) <= acc;
      done(t) <= '1';
      wait;
    end process;
  end generate;

  collector : process
    variable total : unsigned(63 downto 0);
    variable l     : line;
  begin
    wait until done = "1111";
    total := partial(0) + partial(1) + partial(2) + partial(3);
    write(l, to_decimal(total));
    writeline(output, l);
    wait;
  end process;
end architecture;
