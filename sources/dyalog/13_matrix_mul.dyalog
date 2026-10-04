⍝ task 13 matrix_mul — expected output: 599995000
⍝ build: none (interpreted)    run: dyascript -script 13_matrix_mul.dyalog
⍝ note: flat n*n vectors and the plain i, j, k triple loop in that order, exactly as
⍝       sources/c/13_matrix_mul.c writes it. Reordering the loops would be faster and
⍝       that is the point of the task, so the order is left alone. No +.× (matrix
⍝       product) and no inner-product primitive anywhere in the timed path.
⍝ note: APL evaluates right to left, so every index and every product operand is
⍝       parenthesised: (i×n)+k, not i×n+k.
⍝ note: the total is 599995000, far below 2^53, so the double accumulator is exact.
⍝ timing: 3⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←matrix_mul;n;elems;A;B;C;i;j;k;sum;total;ssT0;ssMS
  ssT0←3⊃⎕AI
  n←500
  elems←n×n
  A←elems⍴0
  B←elems⍴0
  C←elems⍴0
  i←0
  :While i<n
    j←0
    :While j<n
      A[(i×n)+j]←7|i+j
      B[(i×n)+j]←5|i×j
      j+←1
    :EndWhile
    i+←1
  :EndWhile
  i←0
  :While i<n
    j←0
    :While j<n
      sum←0
      k←0
      :While k<n
        sum+←(A[(i×n)+k])×(B[(k×n)+j])
        k+←1
      :EndWhile
      C[(i×n)+j]←sum
      j+←1
    :EndWhile
    i+←1
  :EndWhile
  total←0
  i←0
  :While i<elems
    total+←C[i]
    i+←1
  :EndWhile
  ssMS←(3⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt'
  r←⍕total
∇

⎕←matrix_mul
