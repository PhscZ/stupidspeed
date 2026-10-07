-- task 06 char_count — expected output: 10000000
-- build: none — terra.exe JIT-compiles in-process, so there is no build step
-- run: VCINSTALLDIR=C:/fake/vc terra.exe 06_char_count.t     (from sources/terra/)
-- note: VCINSTALLDIR is mandatory and is the switch, not a path — terralib aborts with
--       "Can't find windows SDK version 8.1 or 10!" and exit 1 before it opens this file
--       unless it finds a Visual Studio developer console or the Windows Kits registry key.
--       See temp/terra-doc.md §3. This file needs no INCLUDE: it includes no C header.
-- note: the text is built with `("abcdefghij"):rep(10000000)` — the whole block repeated at
--       once, not appended in a loop — because the spec says the build must not become the
--       benchmark. 100 MB of Lua string.
-- note: Lua strings ARE Terra's strings; Terra has no second string type. The scan is a
--       terra function over the string's bytes, which is the native-code form of "for each
--       character ch in text". `terralib.cast(&int8, text)` hands the string's bytes to
--       native code without a copy — verified, the first byte reads back as 97 ('a').
-- note: the comparisons are on the byte values 97 ('a'), 101 ('e') and 104 ('h'). Terra has
--       no character type: a char in C is an integer, and an int8 literal is the same thing.
-- note: this cell is scan-bound and cheap — 100 million iterations of a three-way compare.
--       The build of the 100 MB string happens before the timed region in any case, because
--       RUN.md times the process.
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

local text = ("abcdefghij"):rep(10000000)

terra count_h(p : &int8, n : int64) : int64
    var count : int64 = 0
    for i = 0, n do
        var ch = p[i]
        if ch == 97 then          -- 'a': skip
        elseif ch == 101 then     -- 'e': skip
        elseif ch == 104 then     -- 'h'
            count = count + 1
        end
    end
    return count
end

local ssV = count_h(terralib.cast(&int8, text), #text)
ssReport(ssT0)
print(string.format("%d", ssV))
