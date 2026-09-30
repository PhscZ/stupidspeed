-- task 15 file_write — expected output: 52428800
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 15_file_write.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: the four CRT functions are
--       declared by hand through terralib.includecstring instead, which is why no C sysroot
--       is needed here.
-- note: THIS ROW DOES SYNC, so it is NOT in the flush-and-close group that the R, Octave,
--       Eiffel, Haxe and Seed7 rows are in. `_commit` is the Windows/CRT name for fsync
--       (FlushFileBuffers underneath) and it resolves and returns 0 here. `fsync` itself is
--       not declared anywhere in the mingw-w64 headers — the only `fsync` in the whole
--       include tree is an unrelated reference in pthread.h — so `_commit` is the name to
--       call. Verified: _commit returns 0 after the 50 MiB write. §8.
-- note: the write goes through the CRT rather than through Lua's io library, even though Lua's
--       io is faster for the bytes themselves (0.0250 s against 0.0580 s for 50 MiB). Lua
--       exposes no descriptor, so a program that writes through `io.open` has nothing to
--       _commit, and the spec asks for a sync. The CRT route is what makes the sync possible.
-- note: the file is opened with _O_WRONLY | _O_CREAT | _O_BINARY and mode _S_IREAD |
--       _S_IWRITE. The BINARY flag is the same load-bearing detail as in 14_file_read.t: in
--       text mode the CRT turns every 0x0A into 0x0D 0x0A and the file would not be a
--       byte-exact 0..255 cycle. Verified byte-exact afterwards at 52428800 bytes.
-- note: `or` is Terra's bitwise-or operator inside terra code; there is no `|`. The flag
--       constants are written as the CRT's own numeric values (0x0002, 0x0100, 0x8000,
--       0x0100, 0x0080) because io.h is not included and Terra has no way to name them.
-- note: the buffer is built once and written 50 times, 1 MiB at a time, exactly as the spec
--       describes — a syscall per byte would measure the kernel and nothing else.
-- note: _write's count parameter is `unsigned int`, so 1048576 is passed as an int literal
--       and converted; the return value is accumulated so the printed number is what the CRT
--       actually accepted, not what was intended.
-- note: measured on this host: 0.0933 s for the 50 MiB write plus the commit, and the file is
--       byte-exact. §8.

local F = terralib.includecstring[[
int _open(const char *path, int flags, int mode);
int _write(int fd, const void *buf, unsigned int count);
int _commit(int fd);
int _close(int fd);
]]

local CHUNK = 1048576

terra write_file(buf : &uint8) : int64
    for i = 0, CHUNK do
        buf[i] = [uint8](i % 256)
    end
    var fd = F._open("out.bin", 0x0002 or 0x0100 or 0x8000, 0x0100 or 0x0080)
    if fd == -1 then
        return -1LL
    end
    var written : int64 = 0
    for k = 0, 50 do
        var n = F._write(fd, buf, CHUNK)
        written = written + [int64](n)
    end
    var rc = F._commit(fd)
    F._close(fd)
    if rc ~= 0 then
        return -2LL
    end
    return written
end

local buf = terralib.new(uint8[CHUNK])

print(string.format("%d", write_file(buf)))
