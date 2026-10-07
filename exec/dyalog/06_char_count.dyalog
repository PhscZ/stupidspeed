⍝ task 06 char_count — expected output: 10000000
⍝ build: none (interpreted)    run: dyascript -script 06_char_count.dyalog
⍝ note: the 100-million-character text is built once with reshape — ⍴ takes the
⍝       *total* element count, so 100000000⍴'abcdefghij' is the ten-character block
⍝       repeated 10 000 000 times, which is the 100 000 000 characters the task
⍝       specifies. Reshaping to 10000000 would be ten times too short and the count
⍝       would come out ten times too small. It is never built by appending in a
⍝       loop, which would turn the build itself into the benchmark.
⍝ note: the scan is a per-character :While loop indexing text[i]. A bulk count such
⍝       as +/'h'=text would do the whole task in one interpreter step and is
⍝       deliberately not used, the same choice the J row records.
⍝ note: the 'a' and 'e' branches are present with empty bodies, as the spec writes
⍝       them; the count only rises on 'h'.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Verified on this machine with Dyalog 20.0: all fifteen tasks
⍝         print the expected line and write time.txt.
⎕IO←0
⎕PP←17

∇ r←char_count;text;n;count;i;ch;ssT0;ssMS
  ssT0←2⊃⎕AI
  text←100000000⍴'abcdefghij'
  n←⍴text
  count←0
  i←0
  :While i<n
    ch←text[i]
    :If ch='a'
      ⍝ skip
    :ElseIf ch='e'
      ⍝ skip
    :ElseIf ch='h'
      count+←1
    :EndIf
    i+←1
  :EndWhile
  ssMS←(2⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt' 1
  r←⍕count
∇

⎕←char_count
