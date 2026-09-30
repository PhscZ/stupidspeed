⍝ task 14 file_read — expected output: 2389704704
⍝ build: none (interpreted)    run: dyascript -script 14_file_read.dyalog
⍝ note: data.bin is the 52428800-byte fixture (bytes 0..255 repeating) in the working
⍝       directory. It is tied with ⎕NTIE and read with ⎕NREAD, and the conversion
⍝       code is 80, 8-bit character: code 83 is 8-bit *signed* integer and rejects
⍝       the 0..255 range outright with "Left argument array could not be converted
⍝       to the requested type", because 256 does not fit a signed byte. ⎕UCS turns
⍝       the characters back into the integers 0..255, and that round trip was
⍝       verified byte for byte before this file was written.
⍝ note: the whole file is read in one ⎕NREAD and then walked one byte at a time.
⍝       Chunking was measured and is nearly irrelevant here — whole file 33.88 s,
⍝       1 MiB chunks 34.89 s, 256 KiB 35.29 s, 4 MiB 50.35 s — so the simplest
⍝       shape is also the fastest, at about 0.65 µs per byte. That cost is the
⍝       interpreter's per-element loop, not I/O.
⍝ note: the running total is 6684672000, far below 2^53, so it is exact, and the
⍝       modulus is taken once at the end with 4294967296|total.
⎕IO←0
⎕PP←17

∇ r←file_read;tie;sz;chunk;codes;total;i
  tie←'data.bin'⎕NTIE 0
  sz←⎕NSIZE tie
  chunk←⎕NREAD tie 80 sz 0
  codes←⎕UCS chunk
  total←0
  i←0
  :While i<sz
    total+←codes[i]
    i+←1
  :EndWhile
  ⎕NUNTIE tie
  r←⍕4294967296|total
∇

⎕←file_read
