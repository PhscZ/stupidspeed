-- task 03 helper — `add_one`, in its own file, as the spec asks
-- build: none — loaded by 03_func_sum.t with terralib.loadfile, not compiled separately
-- run: not run directly; 03_func_sum.t loads this file
-- note: the file returns the terra function, which is how terralib.loadfile hands it to the
--       caller. A `.t` file is a Lua chunk, so `return add_one` is what makes the function
--       visible outside it.
-- note: the caller applies add_one:setinlined(false). That is Terra's no-inline marker and
--       it sets LLVM's `noinline` attribute (terralib.lua: `self.definition.alwaysinline =
--       not not v`); setinlined(true) is the alwaysinline mirror. Without it a cross-file
--       call is inlined anyway and LLVM deletes the whole hundred-million-iteration loop —
--       measured, the loop reduces to `smax(n, 0)` and runs in 0.0000 s against 0.0895 s
--       with the marker. See temp/terra-doc.md §10 for the two disassemblies.

terra add_one(n : int64) : int64
    return n + 1
end

return add_one
