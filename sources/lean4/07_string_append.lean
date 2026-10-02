-- task 07 string_append — expected output: 1000000
-- build: lean -c 07_string_append.c 07_string_append.lean && leanc -O2 -o prog 07_string_append.c    run: ./prog
-- note: `String.push` is Lean's `text + "x"`. It grows the string in place whenever the
--       reference count is one, so the loop is linear; if it copied, this would be quadratic
--       and the million iterations would take hours.

def appendXs (n : Nat) : String :=
  go n ""
where
  go : Nat → String → String
    | 0, text => text
    | n + 1, text => go n (text.push 'x')

def main : IO Unit := do
  IO.println (appendXs 1000000).length
