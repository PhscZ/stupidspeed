-- task 15 file_write — expected output: 52428800
-- build: none (interpreted)    run: C:\stupidspeed\tools\lute\lute.exe run 15_file_write.luau
-- note: THIS FILE NEEDS LUTE, NOT luau.exe, for the same reason as task 14: the plain Luau CLI has
--       no file I/O. Lute (the Luau team's own runtime, tools/lute/lute.exe, release v1.0.0)
--       provides @lute/fs.
-- note: the 1 MiB block is the bytes 0..255 repeated 4096 times, built in a buffer and converted
--       to a string once. out.bin is written in 50 one-megabyte fs.write calls, buffered, because a
--       syscall per byte measures the kernel and nothing else. out.bin is created in the working
--       directory; it must not be left behind in this source directory.
-- note: Lute's @lute/fs exposes no fsync — its whole surface is open/read/write/close/stat/copy/
--       remove/mkdir/rmdir/listdir/exists/link/symlink/type/watch — so the row flushes by closing
--       the handle, the same deviation the D, Julia, Nim, Dart, Pascal and kotlin-native rows note.
--       close is libuv's uv_fs_close, i.e. _close on Windows, which closes the file's last handle;
--       Windows flushes a file's cached data when its last handle goes away.
--       Each fs.write is complete when it returns: libuv's write callback re-issues uv_fs_write
--       until the whole megabyte has been accepted, so the 50 MiB are handed over before the
--       process reaches the close.

local __t0 = os.clock()
local fs = require("@lute/fs")

local CHUNK = 1048576
local PASSES = 50

local chunk = buffer.create(CHUNK)
for i = 0, CHUNK - 1 do
    buffer.writeu8(chunk, i, i % 256)
end
local data = buffer.tostring(chunk)

local out = fs.open("out.bin", "w")

local written = 0
for _ = 1, PASSES do
    fs.write(out, data)
    written = written + #data
end

fs.close(out)

local __t1 = os.clock()
-- Luau exposes no stderr and the plain luau.exe CLI no file I/O, so the timing line is
-- the contract's time.txt fallback, written through Lute's @lute/fs. Under `lute run <file>`
-- it is written; under luau.exe the require fails, the guard skips the write and the run is
-- otherwise unchanged. stdout is never touched.
local __hasfs, __fs = pcall(require, "@lute/fs")
if __hasfs then
    local __h = __fs.open("time.txt", "w")
    __fs.write(__h, string.format("TIME_MS=%.3f\n", (__t1 - __t0) * 1000.0))
    __fs.close(__h)
end
print(written)
