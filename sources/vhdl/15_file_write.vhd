-- task 15 file_write - expected output: 52428800
-- build: ghdl -a --std=08 15_file_write.vhd
-- run: ghdl -r --std=08 t15_file_write
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: the file is 'type byte_file is file of character', NOT a std.textio text file: GHDL
--       appends 'b' to the fopen mode for non-text file types only, and the Windows CRT's text
--       mode would translate every 0x0A in the buffer into CRLF and make out.bin 20% too long.
-- note: DEVIATION: the 1 MiB buffer is written one character per 'write' call, 52428800 calls,
--       rather than one 1 MiB block per call. GHDL's file element type is the unit of I/O and it
--       prepends its own "#GHDL-BINARY-FILE-0.0" signature header for every composite element
--       type (measured: 'file of string(1 to 16)' gets the header), so a 1 MiB array element
--       would produce a file that is not the 52428800 bytes the task asks for. Only scalar
--       element types are clean, and a 4-byte integer element would be an endianness-dependent
--       packing rather than the buffer's own bytes. Each write here is a buffered fwrite(ptr,
--       1, 1) on a FILE*, exactly as in the SystemVerilog row's 52 million single-byte $fwrite
--       calls. The 1 MiB buffer itself is real, and every byte written comes out of it.
-- note: there is no fsync anywhere in VHDL. 'flush(f)' is VHDL-2008's implicit file operation
--       for any file type and GHDL implements it as fflush; file_close adds the implicit close.
--       The row cannot ask the OS to commit the data to the platter, so durability is the OS's
--       business -- the same deviation the other rows that have no fsync record.
-- note: out.bin is written to the working directory, so run the program from sources/vhdl/.
library ieee;
use std.textio.all;

entity t15_file_write is
end entity;

architecture sim of t15_file_write is
  type byte_file is file of character;
  constant CHUNK   : integer := 1048576;
  constant REPEATS : integer := 50;
begin
  process
    file f : byte_file;
    variable buf     : string(1 to CHUNK);
    variable written : integer := 0;
    variable l       : line;
  begin
    for i in 1 to CHUNK loop
      buf(i) := character'val((i - 1) mod 256);
    end loop;

    file_open(f, "out.bin", write_mode);
    for i in 1 to REPEATS loop
      for j in 1 to CHUNK loop
        write(f, buf(j));
      end loop;
      written := written + CHUNK;
    end loop;
    flush(f);
    file_close(f);

    write(l, written);
    writeline(output, l);
    wait;
  end process;
end architecture;
