⍝ task 08 average — expected output: 0.498046875
⍝ build: none (interpreted)    run: dyascript -script 08_average.dyalog
⍝ note: every reading is a multiple of 1/256 and every partial sum is a multiple of
⍝       it too, and the total stays well below 2^53, so the sum is exact in the
⍝       interpreter's 64-bit float and the answer does not depend on the order of
⍝       the additions.
⍝ note: ⎕PP←17 is what makes the printed line exact. The default ⎕PP is 10, and ⍕
⍝       then prints 0.4980468750 — the same value with a trailing zero — while a
⍝       language that prints in %g form would give 0.498047. This is the Dyalog
⍝       counterpart of the J row's ("):!.12) fit form.
⎕IO←0
⎕PP←17

∇ r←average;total;i
  total←0.0
  i←0
  :While i<100000000
    total+←(256|i)÷256.0
    i+←1
  :EndWhile
  r←⍕total÷100000000
∇

⎕←average
