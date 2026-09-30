⍝ task 01 branches — expected output: 33333334 13333333 7619048 45714285
⍝ build: none (interpreted)    run: dyascript -script 01_branches.dyalog
⍝ note: APL evaluates strictly right to left, so `0=3|i` is `0=(3|i)`, which is what
⍝       the spec means. The J row records the same trap.
⍝ note: the four counters are the interpreter's own integers — a 64-bit float is
⍝       what Dyalog has, ⎕DR of 2*62 is 645 — and every count here is far below
⍝       2^53, so they are exact.
⍝ note: the counters are formatted one atom at a time with ⍕ and joined with spaces:
⍝       ⍕ on the whole list would pad every number to a common width and the line
⍝       would not match. The J row does the same for the same reason.
⍝ note: a dfn ({...}) cannot contain control structures, so this is a tradfn.
⍝       Locals are declared after the semicolon in the header, or they are globals.
⎕IO←0
⎕PP←17

∇ r←branches;a;b;c;d;i
  a←0
  b←0
  c←0
  d←0
  i←0
  :While i<100000000
    :If 0=3|i
      a+←1
    :ElseIf 0=5|i
      b+←1
    :ElseIf 0=7|i
      c+←1
    :Else
      d+←1
    :EndIf
    i+←1
  :EndWhile
  r←(⍕a),' ',(⍕b),' ',(⍕c),' ',(⍕d)
∇

⎕←branches
