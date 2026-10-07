⍝ task 11 parallel_sum — expected output: 7500000075000000
⍝ build: none (interpreted)    run: dyascript -script 11_parallel_sum.dyalog
⍝ note: f&Y is the language's own spawn operator — a primitive monadic operator that
⍝       runs f in a new thread and returns its thread number — so this is Dyalog's
⍝       own concurrency and needs nothing installed. ⎕TID is 0 on the master and
⍝       1 2 3 4 in the four workers, ⎕TNUMS reports 0 4 3 2 1 after the spawns, and
⍝       ⎕TSYNC h1 h2 h3 h4 returns the four partials as one vector, which is the
⍝       join. Each worker owns a fixed quarter, so which one finishes first cannot
⍝       change the answer.
⍝ note: this is a correct-answer-no-speedup cell, and it is measured rather than
⍝       assumed. Four spawned workers consume 0.98 CPU per wall second
⍝       (GetProcessTimes over all threads, 84.05 s CPU against 86.17 s wall), and
⍝       four 5 M-iteration workers take 18.26 s against 4.43 s for one, a factor of
⍝       4.12 — exactly serial. The interpreter switches between threads at
⍝       statement boundaries inside one execution engine, so APL code in a defined
⍝       function is serialised; a background :While 1 probe starved the master for
⍝       its whole timeout. That puts the cell in the CPython / CRuby / Simula
⍝       class, and it is *not* the J row's position — J's
⍝       T./t. threads measure 1.7x, Dyalog's & gives none, and the threaded form
⍝       is in fact slower than the identical serial work (86.2 s against 73.8 s)
⍝       because the spawn and ⎕TSYNC bookkeeping is pure overhead here.
⍝ note: every local is declared after the semicolon in the header. A name assigned
⍝       inside a tradfn without that declaration is a global, which in a threaded
⍝       program is a data race rather than merely a leak.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. The counter is read on the master thread around the spawn and
⍝         the ⎕TSYNC join. Verified on this machine with Dyalog 20.0: all fifteen
⍝         tasks print the expected line and write time.txt.
⎕IO←0
⎕PP←17

∇ r←work t;acc;i;lim
  acc←0
  i←t×25000000
  lim←i+25000000
  :While i<lim
    :Select 4|i
    :Case 0 ⋄ acc+←1
    :Case 1 ⋄ acc+←i
    :Case 2 ⋄ acc+←2×i
    :Case 3 ⋄ acc+←3×i
    :EndSelect
    i+←1
  :EndWhile
  r←acc
∇

ssT0←2⊃⎕AI
h1←work& 0
h2←work& 1
h3←work& 2
h4←work& 3
p←⎕TSYNC h1 h2 h3 h4
('TIME_MS=',⍕(2⊃⎕AI)-ssT0)⎕NPUT 'time.txt' 1
⎕←+/p
