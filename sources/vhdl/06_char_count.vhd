-- task 06 char_count - expected output: 10000000
-- build: ghdl -a --std=08 06_char_count.vhd
-- run: ghdl -r --std=08 t06_char_count
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the 100000000-character text is built by doubling whole copies of the 10-character
--       block, never by appending one character at a time: the 10-character block is written
--       once, then copied onto the text 1, 2, 4, ... times its own length, so 24 doublings
--       fill all 100000000 characters and about 100 MB is copied in total.
-- note: the text is a std.textio 'line' (an access-to-string), because VHDL strings are
--       fixed-length arrays and the only growable string type in the standard library is the
--       textio line. DEVIATION: the final 100000000-character string is allocated once at full
--       size and doubled in place, instead of growing a line by repeated concatenation. A
--       concatenation 'text.all & chunk.all' produces an unconstrained function result, which
--       GHDL places on its secondary stack, and that stack raises "exception raised: stack
--       overflow" once a temporary reaches about 32 MiB (measured: 33000000 bytes is fine,
--       34000000 raises; --max-stack-alloc does not lift it) -- which makes the growing version
--       impossible at this size. Allocating the string once and copying slices into it
--       is the same block-repetition build the C row does with its per-block memcpy, and no
--       character is ever appended one at a time.
-- note: the scan is the same shape as the Python row's: 'a' and 'e' are skipped explicitly.
library ieee;
use std.textio.all;

entity t06_char_count is
end entity;

architecture sim of t06_char_count is
  constant BLOCK_LEN : integer := 10;
  constant REPEATS   : integer := 10000000;
  constant TEXT_LEN  : integer := REPEATS * BLOCK_LEN;
  constant CHARS     : string(1 to BLOCK_LEN) := "abcdefghij";
begin
  process
    variable text   : line;
    variable filled : integer;
    variable n      : integer;
    variable count  : integer := 0;
    variable l      : line;
  begin
    text := new string(1 to TEXT_LEN);
    text.all(1 to BLOCK_LEN) := CHARS;
    filled := BLOCK_LEN;
    while filled < TEXT_LEN loop
      n := filled;
      if filled + n > TEXT_LEN then
        n := TEXT_LEN - filled;
      end if;
      text.all(filled + 1 to filled + n) := text.all(1 to n);
      filled := filled + n;
    end loop;

    for i in text.all'range loop
      if text.all(i) = 'a' then
        null;
      elsif text.all(i) = 'e' then
        null;
      elsif text.all(i) = 'h' then
        count := count + 1;
      else
        null;
      end if;
    end loop;

    write(l, count);
    writeline(output, l);
    wait;
  end process;
end architecture;
