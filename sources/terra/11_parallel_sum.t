-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc INCLUDE=<repo>/tools/llvm-mingw/include terra.exe 11_parallel_sum.t
--      (from sources/terra/)
-- note: BOTH environment variables are mandatory here. VCINSTALLDIR is the switch terralib
--       needs before it will open this file at all (without it: "Can't find windows SDK
--       version 8.1 or 10!", exit 1). INCLUDE supplies the C headers, because this is the one
--       file in the row that calls terralib.includec. See temp/terra-doc.md §3 and §5.
-- note: `terralib.includec("windows.h")` needs the extra flag {"-fgnuc-version=4.2.1"}.
--       Without it clang fails with 4583 errors inside its own mmintrin.h: mingw-w64's
--       _mingw.h defines `__attribute__` away when __GNUC__ is undefined, and Terra's clang
--       runs in MSVC compatibility mode on Windows, so every vector typedef in clang's
--       headers loses its __vector_size__. Terralib applies this flag on every platform
--       except Windows (terralib.lua:3525). §5.
-- note: the workers are real OS threads, not Lua coroutines. Lua coroutines are green and
--       Terra's standard library has no thread facility at all, so the route is C
--       CreateThread through includec — the same route the Oberon-07 row takes for the same
--       reason. The four quarters are exactly the spec's: worker t owns
--       [t * 25000000, (t + 1) * 25000000), so the checksum holds however the OS schedules
--       them.
-- note: the worker indices come from an int64[4] ARRAY rather than being written as four
--       literals. With a literal index LLVM constant-folds each quarter's loop bounds and
--       understates the work by 1.7x — a mistake this row made once and recorded in
--       temp/terra-doc.md §16.1, because it also made the speedup look like 2.17x instead of
--       3.72x.
-- note: measured on this host: 0.04902 s serial against 0.01317 s on four workers, a 3.72x
--       speedup, with process CPU/wall of 4.75 (0.0625 s of CPU inside 0.0132 s of wall) and
--       four distinct thread ids (13592, 22392, 20844, 26564). Correct-answer-with-speedup,
--       not a correct-answer-no-speedup cell. §7.
-- note: `for i = 0, 4 do` is Terra's half-open range, so it runs i = 0..3 — four workers, not
--       five. The 4 in `C.HANDLE[4]` and the 4 in the loop bound are the same 4.
-- note: `|` is not an operator in Terra; `or` is the bitwise one inside terra code. The
--       _open() flag expressions in 15_file_write.t rely on that.

struct Work { t : int64; result : int64; tid : uint32 }

local C = terralib.includec("windows.h", terralib.newlist{"-fgnuc-version=4.2.1"})

local QUARTER = 25000000LL

terra work(t : int64) : int64
    var acc : int64 = 0
    var i : int64 = t * QUARTER
    var stop : int64 = i + QUARTER
    while i < stop do
        var m : int64 = i % 4
        if m == 0 then
            acc = acc + 1
        elseif m == 1 then
            acc = acc + i
        elseif m == 2 then
            acc = acc + 2 * i
        else
            acc = acc + 3 * i
        end
        i = i + 1
    end
    return acc
end

terra threadproc(p : C.LPVOID) : uint32
    var w = [&Work](p)
    w.tid = C.GetCurrentThreadId()
    w.result = work(w.t)
    return 0
end

terra parallel_sum(idx : &int64, ws : &Work) : int64
    var handles : C.HANDLE[4]
    for i = 0, 4 do
        ws[i].t = idx[i]
        handles[i] = C.CreateThread(nil, 0, threadproc, [C.LPVOID](&ws[i]), 0, nil)
    end
    var total : int64 = 0
    for i = 0, 4 do
        C.WaitForSingleObject(handles[i], 4294967295ULL)   -- INFINITE
        total = total + ws[i].result
    end
    return total
end

local idx = terralib.new(int64[4], {0LL, 1LL, 2LL, 3LL})
local ws = terralib.new(Work[4])

print(string.format("%d", parallel_sum(idx, ws)))
