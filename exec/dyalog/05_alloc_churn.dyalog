⍝ task 05 alloc_churn — expected output: 1274991808
⍝ build: none (interpreted)    run: dyascript -script 05_alloc_churn.dyalog
⍝ note: the buffer is a 64-element numeric vector, the analogue of the C row's
⍝       64-byte block; Dyalog's atoms are 8-byte doubles or 1-byte characters, so
⍝       a 64-element vector is 512 bytes of interpreter storage rather than 64.
⍝       The task's shape is what is being measured — ten million small allocations
⍝       with the previous occupant of the slot dropped — and that is what this is.
⍝ note: the slots vector is boxed (256⍴⊂⍬), so storing a buffer needs an enclosure:
⍝       slots[256|i]←⊂buf. Without the ⊂ the 64 elements would be spread across 64
⍝       slots instead of one, and the old buffer would not be dropped. The slot the
⍝       new buffer replaces is what becomes garbage, which is the point of the task.
⍝ note: total is 1274991808, below 2^53, so the double accumulator is exact.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←alloc_churn;slots;total;i;buf;ssT0;ssMS
  ssT0←2⊃⎕AI
  slots←256⍴⊂⍬
  total←0
  i←0
  :While i<10000000
    buf←64⍴0
    buf[0]←256|i
    total+←buf[0]
    slots[256|i]←⊂buf
    i+←1
  :EndWhile
  ssMS←(2⊃⎕AI)-ssT0
  ('TIME_MS=',⍕ssMS)⎕NPUT 'time.txt' 1
  r←⍕total
∇

⎕←alloc_churn
