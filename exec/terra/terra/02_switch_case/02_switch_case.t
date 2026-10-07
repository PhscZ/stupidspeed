-- task 02 switch_case — expected output: 7500000075000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 02_switch_case.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: `i % 4` in Terra is C's `%`, which truncates toward zero and takes the sign of the
--       dividend — not Lua's floor-mod. `i` is non-negative here so the two agree, and the
--       answer is exact in int64 either way.
-- note: the total stays under 2^53 and fits int64 comfortably: the true sum is 7.5e15 and
--       int64 holds 9.2e18.
-- note: the loop is scalar. LLVM unrolls it by 2 and strength-reduces `2 * i` and `3 * i`
--       into incrementally maintained registers; there is no SIMD in the IR or in the
--       machine code. Measured on this host the cell runs at about 0.40 ns per iteration
--       against 1.70 ns for the C row's clang -O2 build and 1.90 ns for its gcc -O2 build.
--       That is a toolchain effect and it is disclosed in temp/terra-doc.md §7.1, together
--       with the mod-7 control loop that proves the modulo is really being computed.
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

terra switch_case() : int64
    var acc : int64 = 0
    for i = 0, 100000000 do
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
    end
    return acc
end

local ssV = switch_case()
ssReport(ssT0)
print(string.format("%d", ssV))
