⍝ task 07 string_append — expected output: 250000
⍝ build: none (interpreted)    run: dyascript -script 07_string_append.dyalog
⍝ note: text,←'x' is the plain append the task asks for, and it is what this file
⍝       measures. It is a documented deviation: Dyalog appends into the existing
⍝       buffer when the same name is on both sides, so the loop is amortised linear
⍝       rather than the quadratic copy the task is designed to probe. This puts the
⍝       cell in the same class as the Raku, Erlang, Elixir, Eiffel,
⍝       Seed7 and J rows, which record the same optimisation. It is recorded rather
⍝       than worked around: forcing a copy would mean writing the row artificially.
⎕IO←0
⎕PP←17

∇ r←string_append;text;i
  text←''
  i←0
  :While i<250000
    text,←'x'
    i+←1
  :EndWhile
  r←⍕⍴text
∇

⎕←string_append
