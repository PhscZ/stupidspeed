⍝ task 10 pi — expected output: 4470
⍝ build: none (interpreted)    run: dyascript -script 10_pi.dyalog
⍝ note: Gibbons' unbounded spigot, the same state machine as sources/c/10_pi.c and
⍝       sources/janet/10_pi.janet, on hand-rolled sign-magnitude base-1e9 limbs.
⍝       Dyalog has neither a 64-bit integer type nor a bignum: ⎕DR of 2*62 is 645,
⍝       a 64-bit float, and 2*53+1 = 2*53, so this is the Janet row's situation.
⍝       A limb times the spigot's largest multiplier is exact — l reaches 23200 at
⍝       1000 digits, so a limb times a multiplier is at most 1e9*23200 = 2.32e13,
⍝       well inside the 2^53 where a double is exact — and every carry and every
⍝       quotient is a small integer. That is the whole correctness argument, and it
⍝       is why no 128-bit type is needed.
⍝ note: a bignum is one flat vector: element 0 is the sign (+1 or ¯1) and the rest
⍝       are the base-1e9 limbs, least significant first. A nested pair does not work
⍝       here: with ⎕IO←0, x[1] on a vector whose second element is enclosed returns
⍝       the enclosure rather than the vector, so every read would need a disclose.
⍝ note: r goes negative during the spigot — 994 times in the 4313 steps the
⍝       1000-digit run takes, counted independently in Python against the same
⍝       algorithm — so the representation carries a sign rather than being a bare
⍝       magnitude.
⍝ note: APL evaluates strictly right to left, so every comparison whose left operand
⍝       is an expression is parenthesised: (4×q)+r<t×n would be (4×q)+(r<t×n) and
⍝       would then feed a number to :If, which wants a Boolean singleton. This is
⍝       the same trap the J row records, and it is the one that produced
⍝       "Boolean singleton value required" while this file was being written.
⍝ note: the dyadic helpers are declared infix, as APL requires: the header is
⍝       ∇ r←a badd b, not ∇ r←badd a b. The second form is not a syntax error, it
⍝       silently defines a function named a instead, which then shows up as an
⍝       undefined name at the call site.
⍝ note: the limb routines are explicit element loops, not APL primitives doing the
⍝       work in bulk, which is the reading of the rules the J row records. The only
⍝       primitives on the timed path are scalar arithmetic and ⌊ | ÷ on limbs.
⍝ note: Dyalog forces one structural choice: a dfn ({...}) cannot contain control
⍝       structures ("dfns do not support control structures or branch"), so every
⍝       function here is a tradfn (∇...∇). Locals must be declared after the
⍝       semicolon in the header or they are globals, which would be a data race
⍝       under task 11.
⍝ timing: 2⊃⎕AI is Dyalog's elapsed-time counter in milliseconds. APL exposes no
⍝         stream handle for stderr, so the contract's fallback applies: TIME_MS is
⍝         written to time.txt in the working directory with ⎕NPUT, and stdout is
⍝         unchanged. Instrumented by inspection: Dyalog is not installed on this
⍝         machine, so this row's timing is unverified.
⎕IO←0
⎕PP←17

∇ r←norm x;h;l
  ⍝ normalise: drop leading zero limbs and force the sign of zero to +1, so that
  ⍝ two zeros always compare equal.
  h←⊃x
  l←1↓x
  :While ((⍴l)>1)∧(0=l[(⍴l)-1])
    l←¯1↓l
  :EndWhile
  :If l≡,0
    r←1,0
  :Else
    r←h,l
  :EndIf
∇

∇ r←bz
  r←1,0
∇

∇ r←bi v;l;s
  ⍝ a small non-negative integer as a bignum; the sign is handled so that the
  ⍝ helper is safe to call with a negative value as well.
  s←1
  :If v<0
    s←¯1
    v←-v
  :EndIf
  l←⍬
  :While v>0
    l←l,(1000000000|v)
    v←⌊v÷1000000000
  :EndWhile
  :If (⍴l)=0
    l←,0
  :EndIf
  r←s,l
∇

∇ r←al amag bl;n;s;carry;i;ai;bi;v
  ⍝ |a| + |b| on the limbs
  n←(⍴al)⌈⍴bl
  s←n⍴0
  carry←0
  i←0
  :While i<n
    ai←0
    :If i<⍴al
      ai←al[i]
    :EndIf
    bi←0
    :If i<⍴bl
      bi←bl[i]
    :EndIf
    v←ai+bi+carry
    :If v≥1000000000
      v←v-1000000000
      carry←1
    :Else
      carry←0
    :EndIf
    s[i]←v
    i+←1
  :EndWhile
  :If carry=1
    s←s,1
  :EndIf
  r←s
∇

∇ r←al smag bl;n;s;borrow;i;ai;bi;v
  ⍝ |a| - |b|, which requires |a| ≥ |b|
  n←⍴al
  s←n⍴0
  borrow←0
  i←0
  :While i<n
    ai←al[i]
    bi←0
    :If i<⍴bl
      bi←bl[i]
    :EndIf
    v←(ai-bi)-borrow
    :If v<0
      v←v+1000000000
      borrow←1
    :Else
      borrow←0
    :EndIf
    s[i]←v
    i+←1
  :EndWhile
  r←s
∇

∇ r←al cmpmag bl;i
  :If (⍴al)>⍴bl
    r←1
  :ElseIf (⍴al)<⍴bl
    r←¯1
  :Else
    r←0
    i←(⍴al)-1
    :While i≥0
      :If al[i]>bl[i]
        r←1
        :Leave
      :ElseIf al[i]<bl[i]
        r←¯1
        :Leave
      :EndIf
      i-←1
    :EndWhile
  :EndIf
∇

∇ r←a bcmp b;ah;bh;c
  ah←⊃a
  bh←⊃b
  :If ah>bh
    r←1
  :ElseIf ah<bh
    r←¯1
  :Else
    c←(1↓a) cmpmag (1↓b)
    :If ah=¯1
      r←-c
    :Else
      r←c
    :EndIf
  :EndIf
∇

∇ r←a badd b;c
  :If (⊃a)=⊃b
    r←norm (⊃a),(1↓a) amag (1↓b)
  :Else
    c←(1↓a) cmpmag (1↓b)
    :If c=0
      r←bz
    :ElseIf c>0
      r←norm (⊃a),(1↓a) smag (1↓b)
    :Else
      r←norm (⊃b),(1↓b) smag (1↓a)
    :EndIf
  :EndIf
∇

∇ r←a bsub b;c
  :If (⊃a)≠⊃b
    r←norm (⊃a),(1↓a) amag (1↓b)
  :Else
    c←(1↓a) cmpmag (1↓b)
    :If c=0
      r←bz
    :ElseIf c>0
      r←norm (⊃a),(1↓a) smag (1↓b)
    :Else
      r←norm (-⊃a),(1↓b) smag (1↓a)
    :EndIf
  :EndIf
∇

∇ r←a bmul m;al;l;carry;i;v;n
  :If (m=0)∨(1↓a)≡,0
    r←bz
  :Else
    al←1↓a
    n←⍴al
    l←n⍴0
    carry←0
    i←0
    :While i<n
      v←(al[i]×m)+carry
      l[i]←1000000000|v
      carry←⌊v÷1000000000
      i+←1
    :EndWhile
    :While carry>0
      l←l,(1000000000|carry)
      carry←⌊carry÷1000000000
    :EndWhile
    r←norm (⊃a),l
  :EndIf
∇

∇ r←a bquot b;w;q
  ⍝ floor(a/b) for a ≥ 0 and b > 0, by repeated subtraction — the same routine the
  ⍝ C row uses. The spigot only ever asks for a quotient of one or two decimal
  ⍝ digits, so counting how many times b fits into a is both exact and cheap, and
  ⍝ it needs no estimate that could be wrong. A negative a returns 0, as in C.
  q←0
  w←b
  :While (a bcmp w)≥0
    q+←1
    w←w badd b
  :EndWhile
  r←q
∇

∇ r←pi n;q;rr;t;k;l;m;u;v;sum;produced;next
  q←bi 1
  rr←bi 0
  t←bi 1
  k←1
  l←3
  m←3
  sum←0
  produced←0
  :While produced<n
    u←(q bmul 4) badd rr
    v←t bmul (m+1)
    :If ((u bcmp v)<0)
      ⍝ the digit m is settled
      sum+←m
      produced+←1
      u←((q bmul 3) badd rr) bmul 10
      next←(u bquot t)-10×m
      rr←(rr bsub (t bmul m)) bmul 10
      q←q bmul 10
      m←next
    :Else
      ⍝ not settled: widen the state by one more term
      u←(q bmul (7×k)+2) badd (rr bmul l)
      v←t bmul l
      next←u bquot v
      rr←((q bmul 2) badd rr) bmul l
      q←q bmul k
      t←t bmul l
      k+←1
      l+←2
      m←next
    :EndIf
  :EndWhile
  r←⍕sum
∇

ssT0←2⊃⎕AI
ssR←pi 1000
('TIME_MS=',⍕(2⊃⎕AI)-ssT0)⎕NPUT 'time.txt' 1
⎕←ssR
