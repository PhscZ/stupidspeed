⍝ task 07 string_append — expected output: 250000
⍝ build: none (interpreted)    run: dyascript -script 07_string_append.dyalog
⍝ note: text,←'x' is the plain append the task asks for, and it is what this file
⍝       measures. It is a documented deviation: Dyalog appends into the existing
⍝       buffer when the same name is on both sides, so the loop is amortised linear
⍝       rather than the quadratic copy the task is designed to probe. This puts the
⍝       cell in the same class as the Raku, Erlang, Elixir, Eiffel,
⍝       Seed7 and J rows, which record the same optimisation. It is recorded rather
⍝       than worked around: forcing a copy would mean writing the row artificially.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←string_append;text;i;ssT0;ssMS
  ssT0←2⊃⎕AI
  text←''
  i←0
  :While i<250000
    text,←'x'
    i+←1
  :EndWhile
  ssMS←(2⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt' 1
  r←⍕⍴text
∇

⎕←string_append
