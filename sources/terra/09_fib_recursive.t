-- task 09 fib_recursive — expected output: 102334155
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 09_fib_recursive.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: DEVIAITON, recorded because the number cannot be read the obvious way. The algorithm
--       is the naive double recursion the spec asks for and the answer is exact, but LLVM's
--       accumulator-recursion transform rewrites ONE of the two recursive calls into a tail
--       call inside a loop, so the machine code is not a `call`/`ret` pair per node. Measured
--       at 0.67 ns per source-level call over 331160281 calls, which is far below the 3-5 ns
--       a real call frame costs. The φ^n scaling below shows the full 2^n call structure is
--       still executed, so nothing is memoised and no shortcut is taken — but the cell
--       measures a tail call, not a call frame. temp/terra-doc.md §13 has the disassembly.
--       The Nelua row records the same class of finding for its own fib.
-- note: `fib:disas()` was checked directly. The body becomes a `merge` block with
--       `%3 = tail call i64 @"$fib"(i64 %2)` and a `phi` accumulator, which is the transform
--       named above; the non-transformed half is still a real recursive call.
-- note: measured scaling on this host, calls = 2*fib(n+1)-1:
--       fib(24) 150049 calls 0.68 ns/call; fib(28) 1028457 0.67; fib(32) 7049155 0.69;
--       fib(36) 48315633 0.68; fib(40) 331160281 0.67. Flat per-call cost and exponential
--       growth in n, which is exactly naive recursion.
-- note: the JIT compiles this function ONCE. Measured: the first fib(30) costs 0.01728 s and
--       the second 0.00181 s, so 15.5 ms of the first call is codegen and is paid once per
--       process, not per call.
-- note: `int64` throughout. fib(40) = 102334155 fits in 32 bits, but the recursion's
--       intermediates do not need to be re-examined for that, and int64 is the type every
--       other row uses.
-- timing: GetSystemTimePreciseAsFileTime is Windows' 100-nanosecond clock, imported
--         with terralib.externfunction; TIME_MS goes to time.txt, the contract's
--         fallback, because Terra's stdio has no stderr handle. stdout is unchanged.
local C = terralib.includec("stdio.h")
local GetSystemTimePreciseAsFileTime = terralib.externfunction("GetSystemTimePreciseAsFileTime", &int64 -> {})
terra ssNow() : int64
    var ft : int64
    GetSystemTimePreciseAsFileTime(&ft)
    return ft / 10000LL
end
terra ssReport(t0 : int64) : int64
    var f = C.fopen("time.txt", "w")
    C.fprintf(f, "TIME_MS=%lld\n", ssNow() - t0)
    C.fclose(f)
    return 0
end
local ssT0 = ssNow()

terra fib(n : int64) : int64
    if n < 2 then
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

local ssV = fib(40LL)
ssReport(ssT0)
print(string.format("%d", ssV))
