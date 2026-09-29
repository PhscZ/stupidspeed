-- task 14 file_read - expected output: 2389704704
-- build: ghdl -a --std=08 14_file_read.vhd
-- run: ghdl -r --std=08 t14_file_read
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the file is 'type byte_file is file of character', NOT a std.textio text file. GHDL
--       appends 'b' to the fopen mode for every non-text file type and omits it for text files,
--       so a text file would be opened in the Windows CRT's text mode, which treats byte 0x1A
--       as end of file and translates CRLF on output. data.bin has 0x1A at offset 26, so a text
--       file would stop there and print a tiny wrong number. This is the row's worst trap.
-- note: DEVIATION: the 1 MiB chunk is filled one byte per 'read' call rather than in one bulk
--       read. GHDL's file element type is the unit of I/O, and it writes and requires its own
--       "#GHDL-BINARY-FILE-0.0" signature header for every composite element type (measured:
--       'file of string(1 to 16)' and 'file of array (0 to 7) of bit' both get the header, and
--       reading data.bin through one fails at open with "ghdl:internal error: file: IO error").
--       Only scalar element types are clean -- 'file of integer' writes exactly its four bytes
--       -- and a 4-byte integer is not the task's byte-at-a-time read. Each read here is a
--       buffered fread(ptr, 1, 1) on a FILE*, so there is still no syscall per byte, but there
--       is a call per byte. The chunk is a real 1 MiB buffer and the per-byte accumulation
--       happens inside it, exactly as in the C row.
-- note: the per-chunk running sum is a 32-bit 'integer' (1 MiB of 0..255 is at most 267386880,
--       which fits), and only the chunk sums go into the unsigned(31 downto 0) accumulator,
--       whose '+' is modular -- so "total mod 4294967296" falls out of the type. Adding every
--       byte straight into the unsigned vector would put one 64-bit numeric_std operation per
--       byte in the loop; under the mcode backend each of those allocates its result on GHDL's
--       secondary stack, measured at 9.8 us, which turns this 1.9-second cell into an
--       8.5-minute one.
-- note: the loop is counted, not 'while not endfile(f)': GHDL implements endfile as fgetc plus
--       ungetc on every call, and the fixture's size is fixed by the spec (50 MiB = 204800
--       repetitions of the byte cycle 0..255), so counting to 52428800 is exact.
-- note: data.bin is read from the working directory, so run the program from sources/vhdl/ with
--       a copy of temp/data.bin beside it.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity t14_file_read is
end entity;

architecture sim of t14_file_read is
  type byte_file is file of character;
  constant CHUNK : integer := 1048576;
  constant REPS  : integer := 50;

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
    file f : byte_file;
    variable buf     : string(1 to CHUNK);
    variable partial : integer;
    variable total   : unsigned(31 downto 0) := (others => '0');
    variable l       : line;
  begin
    file_open(f, "data.bin", read_mode);
    for c in 1 to REPS loop
      for i in 1 to CHUNK loop
        read(f, buf(i));
      end loop;
      partial := 0;
      for i in 1 to CHUNK loop
        partial := partial + character'pos(buf(i));
      end loop;
      total := total + to_unsigned(partial, 32);
    end loop;
    file_close(f);
    write(l, to_decimal(total));
    writeline(output, l);
    wait;
  end process;
end architecture;
