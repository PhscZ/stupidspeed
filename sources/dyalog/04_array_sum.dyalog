⍝ task 04 array_sum — expected output: 499999500000
⍝ build: none (interpreted)    run: dyascript -script 04_array_sum.dyalog
⍝ note: the million-element array is a plain numeric vector, filled and read one
⍝       element at a time in explicit :While loops. No ⍳-based fill and no +/arr —
⍝       a bulk primitive would do the whole task in one interpreter step, which is
⍝       the reading of the rules the J row records for this row.
⍝ note: arr[i]←i is an in-place amend on a name that appears on both sides, so the
⍝       interpreter does not copy the million-element array per iteration.
⍝ note: the total is 499999500000, below 2^53, so the double accumulator is exact.
⎕IO←0
⎕PP←17

∇ r←array_sum;arr;i;total
  arr←1000000⍴0
  i←0
  :While i<1000000
    arr[i]←i
    i+←1
  :EndWhile
  total←0
  i←0
  :While i<1000000
    total+←arr[i]
    i+←1
  :EndWhile
  r←⍕total
∇

⎕←array_sum
