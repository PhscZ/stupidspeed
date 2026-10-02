-- task 03 func_sum — expected output: 100000000
-- build: none (interpreted)    run: C:\stupidspeed\tools\luau\luau.exe 03_func_sum.luau
-- note: also runs unchanged on Lute, the Luau team's runtime: C:\stupidspeed\tools\lute\lute.exe run 03_func_sum.luau
-- The plain Luau CLI interprets bytecode with no JIT, so the call happens 100000000 times; the
-- compiler is left at its default -O1, which does not inline this one. Luau has no no-inline
-- directive, so nothing marks the function, the same caveat the Lua row carries.

local function add_one(n)
    return n + 1
end

local value = 0
for _ = 1, 100000000 do
    value = add_one(value)
end

print(value)
