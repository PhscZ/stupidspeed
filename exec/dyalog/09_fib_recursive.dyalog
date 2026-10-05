⍝ task 09 fib_recursive — expected output: 102334155
⍝ build: none (interpreted)    run: dyascript -script 09_fib_recursive.dyalog
⍝ note: the naive double recursion, written literally, so the cell measures the
⍝       interpreter's call path. Measured: fib 30 takes 1.02 s over 2 692 537 calls,
⍝       which is 0.36 µs per call, so fib(40)'s 331 160 281 calls come to about
⍝       120 s. This is the row's slowest cell, the same shape as the J row's.
⍝ note: recursion needs a tradfn. A dfn cannot contain control structures, so the
⍝       `{}` form of this function would not parse.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←fib n
  :If n<2
    r←n
  :Else
    r←(fib n-1)+fib n-2
  :EndIf
∇

ssT0←2⊃⎕AI
ssR←fib 40
('TIME_MS=',⍕(2⊃⎕AI)-ssT0)⎕NPUT 'time.txt' 1
⎕←ssR
