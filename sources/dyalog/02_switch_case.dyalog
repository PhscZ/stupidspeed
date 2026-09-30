⍝ task 02 switch_case — expected output: 7500000075000000
⍝ build: none (interpreted)    run: dyascript -script 02_switch_case.dyalog
⍝ note: :Select/:Case is APL's own switch, which is the form the task asks for.
⍝ note: ⎕PP←17 is load-bearing for this cell. The default ⎕PP is 10, and ⍕ of the
⍝       total then prints 7.500000075E15 instead of the exact digits; measured, with
⍝       the default the cell would be WRONG. 17 is the maximum ⎕PP accepts and the
⍝       total is 16 digits, so it prints in full.
⍝ note: the total is 7500000075000000, below 2^53, so the interpreter's double
⍝       arithmetic is exact and the digits are the true ones.
⎕IO←0
⎕PP←17

∇ r←switch;acc;i
  acc←0
  i←0
  :While i<100000000
    :Select 4|i
    :Case 0 ⋄ acc+←1
    :Case 1 ⋄ acc+←i
    :Case 2 ⋄ acc+←2×i
    :Case 3 ⋄ acc+←3×i
    :EndSelect
    i+←1
  :EndWhile
  r←⍕acc
∇

⎕←switch
