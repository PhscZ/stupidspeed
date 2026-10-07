-- task 11 parallel_sum — expected output: 7500000075000000
-- build: none (interpreted)
-- run: EUDIR="C:\stupidspeed\tools\euphoria" C:\stupidspeed\tools\euphoria\bin\eui.exe 11_parallel_sum.ex
-- timing: QueryPerformanceCounter via kernel32 FFI; TIME_MS goes to time.txt (Euphoria
--         cannot reach stderr in this build). Only the parent branch times.
-- note: std/task.e segfaults in this build (signal 11 on task_create), so real parallelism
--       uses four child processes. The file is self-invoking: with no argument it is the
--       parent, with one argument it is the worker for that range. The parent launches each
--       worker with `cmd /c start "" /b ...`, which returns immediately (system_exec on its
--       own waits for the child, so it would serialise them), then polls until all four
--       partial files are complete. The workers are genuinely concurrent OS processes, so
--       this is real parallelism across four cores.

include std/dll.e
include std/machine.e
include std/cmdline.e
include std/convert.e
include std/os.e
include std/io.e
include std/filesys.e

atom k32, freq, buf, t0, t1, r, ms
integer pF, pC
k32 = open_dll("kernel32.dll")
pF = define_c_func(k32, "QueryPerformanceFrequency", {C_POINTER}, C_LONG)
pC = define_c_func(k32, "QueryPerformanceCounter", {C_POINTER}, C_LONG)
buf = allocate(8)
r = c_func(pF, {buf})
freq = peek8u(buf)
r = c_func(pC, {buf})
t0 = peek8u(buf)

function work(integer t)
    integer acc, first, last, c
    acc = 0
    first = t * 25000000
    last = first + 25000000 - 1
    for i = first to last do
        c = remainder(i, 4)
        if c = 0 then
            acc = acc + 1
        elsif c = 1 then
            acc = acc + i
        elsif c = 2 then
            acc = acc + 2 * i
        else
            acc = acc + 3 * i
        end if
    end for
    return acc
end function

sequence c
c = command_line()

if length(c) >= 3 then
    integer t, fh
    t = to_integer(c[3])
    fh = open("partial" & sprintf("%d", t) & ".txt", "w")
    printf(fh, "%d\n", {work(t)})
    close(fh)
else
    integer done, total, fh
    object line
    for t = 0 to 3 do
        delete_file("partial" & sprintf("%d", t) & ".txt")
    end for
    for t = 0 to 3 do
        atom h
        h = system_exec("cmd /c start \"\" /b \"" & c[1] & "\" \"" & c[2] & "\" " & sprintf("%d", t), 2)
    end for
    done = 0
    while done < 4 do
        done = 0
        for t = 0 to 3 do
            fh = open("partial" & sprintf("%d", t) & ".txt", "r")
            if fh >= 0 then
                line = gets(fh)
                if sequence(line) and length(line) > 0 then
                    done = done + 1
                end if
                close(fh)
            end if
        end for
        if done < 4 then
            sleep(0.005)
        end if
    end while
    total = 0
    for t = 0 to 3 do
        fh = open("partial" & sprintf("%d", t) & ".txt", "r")
        line = gets(fh)
        if sequence(line) and length(line) > 0 and line[length(line)] = '\n' then
            line = line[1 .. length(line) - 1]
        end if
        total = total + to_integer(line)
        close(fh)
    end for
    r = c_func(pC, {buf})
    t1 = peek8u(buf)
    ms = (t1 - t0) * 1000.0 / freq
    printf(1, "%d\n", {total})
    fh = open("time.txt", "w")
    printf(fh, "TIME_MS=%.3f\n", {ms})
    close(fh)
end if
