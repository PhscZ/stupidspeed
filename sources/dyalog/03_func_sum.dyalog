⍝ task 03 func_sum — expected output: 100000000
⍝ build: none (interpreted)    run: dyascript -script 03_func_sum.dyalog
⍝ note: the helper lives in AddOne.dyalog and is fixed into the workspace with
⍝       2 ⎕FIX, so the call crosses a file boundary — the shape the Fortran, Tcl,
⍝       Vala, J and Janet rows use for this task. Dyalog is interpreted and has no
⍝       no-inline marker; there is no inliner to defeat, and the measured 0.578 µs
⍝       per call (578 ms for 1 000 000 calls) against a visibly cheaper inline loop
⍝       shows the call is real. 100 000 000 calls therefore cost about 58 s.
⍝ note: the run line must be executed from sources/dyalog/, because 2 ⎕FIX resolves
⍝       the name against the working directory.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Verified on this machine with Dyalog 20.0: all fifteen tasks
⍝         print the expected line and write time.txt.
⎕IO←0
⎕PP←17

2 ⎕FIX 'AddOne.dyalog'

∇ r←func_sum;value;i;ssT0;ssMS
  ssT0←2⊃⎕AI
  value←0
  i←0
  :While i<100000000
    value←add_one value
    i+←1
  :EndWhile
  ssMS←(2⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt' 1
  r←⍕value
∇

⎕←func_sum
