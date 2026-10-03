-- task 07 string_append — expected output: 250000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 07_string_append.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 07_string_append.luau
-- One character appended per iteration, 250000 times. Luau strings are immutable and there is no
-- growable string type, so each append copies the whole string and the task is quadratic; a string
-- buffer would have to be an explicit table of chunks, which is a different program.

local text = ""
for _ = 1, 250000 do
    text = text .. "x"
end

print(#text)
