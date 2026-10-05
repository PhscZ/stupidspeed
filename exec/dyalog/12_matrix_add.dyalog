⍝ task 12 matrix_add — expected output: 999000000
⍝ build: none (interpreted)    run: dyascript -script 12_matrix_add.dyalog
⍝ note: the three matrices are flat million-element vectors indexed i*n+j, the same
⍝       shape the Ring and Octave rows use, and every element is written and read
⍝       one at a time in explicit loops. No bulk primitive does the work: not
⍝       A+B for the addition and not +/C for the total, either of which would
⍝       collapse the task into one interpreter step.
⍝ note: APL evaluates strictly right to left, so the index is written (i×n)+j.
⍝       The unparenthesised i×n+j would be i×(n+j).
⍝ note: the values are small integers and the total is 999000000, far below 2^53, so
⍝       the double arithmetic is exact throughout.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←matrix_add;n;elems;A;B;C;i;j;total;ssT0;ssMS
  ssT0←2⊃⎕AI
  n←1000
  elems←n×n
  A←elems⍴0
  B←elems⍴0
  C←elems⍴0
  i←0
  :While i<n
    j←0
    :While j<n
      A[(i×n)+j]←i+j
      B[(i×n)+j]←i-j
      j+←1
    :EndWhile
    i+←1
  :EndWhile
  i←0
  :While i<elems
    C[i]←A[i]+B[i]
    i+←1
  :EndWhile
  total←0
  i←0
  :While i<elems
    total+←C[i]
    i+←1
  :EndWhile
  ssMS←(2⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt' 1
  r←⍕total
∇

⎕←matrix_add
