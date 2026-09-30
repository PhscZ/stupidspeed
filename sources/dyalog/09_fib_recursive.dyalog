⍝ task 09 fib_recursive — expected output: 102334155
⍝ build: none (interpreted)    run: dyascript -script 09_fib_recursive.dyalog
⍝ note: the naive double recursion, written literally, so the cell measures the
⍝       interpreter's call path. Measured: fib 30 takes 1.02 s over 2 692 537 calls,
⍝       which is 0.36 µs per call, so fib(40)'s 331 160 281 calls come to about
⍝       120 s. This is the row's slowest cell, the same shape as the J row's.
⍝ note: recursion needs a tradfn. A dfn cannot contain control structures, so the
⍝       `{}` form of this function would not parse.
⎕IO←0
⎕PP←17

∇ r←fib n
  :If n<2
    r←n
  :Else
    r←(fib n-1)+fib n-2
  :EndIf
∇

⎕←fib 40
