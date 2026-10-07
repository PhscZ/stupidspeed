⍝ AddOne.dyalog — the task 03 helper, in its own file.
⍝ Loaded by 03_func_sum.dyalog with `2 ⎕FIX 'AddOne.dyalog'`, which fixes the script
⍝ into the workspace. Dyalog is an interpreter and has no no-inline marker, so there
⍝ is nothing to defeat: the helper is a real defined function in the workspace and
⍝ every call is a real call. Splitting it into a second file is the spec's own
⍝ option and the shape the other interpreted rows use, not a workaround.
⍝ `2 ⎕FIX` needs the plain relative file name; 'file://AddOne.dyalog' fails with
⍝ DOMAIN ERROR, and the file's text cannot be fed to ⎕FIX either.

∇ r←add_one n
  r←n+1
∇
