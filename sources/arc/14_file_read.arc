; task 14 file_read — expected output: 2389704704
; build: none (Arc is interpreted; the Racket host loads tools/arc/arc.arc on every run)    run: C:\stupidspeed\tools\racket\Racket.exe -t C:\stupidspeed\tools\arc\boot.rkt -e "(anarki-windows-cli)" -- 14_file_read.arc
; note: run from this directory (sources/arc), with a copy of data.bin in it. The .arc file is named
;       relative to that directory; boot.rkt is given by absolute path so the host finds its own
;       libraries.
; note: Arc here is Anarki -- Arc 3.2 plus its lib/ tree -- on Racket 9.3 CS. There is no separate
;       build step and no compiled form of the task file, so the host's own boot (about 30 s on this
;       machine) is inside every measured run.
; note: the file is read in 1 MiB chunks with Arc's own `readbytes` (Racket's read-bytes), and every
;       byte is added up. `readbytes` returns nil at end of file, which is what ends the loop.
; note: the running total is reduced mod 2^32 after each chunk, so it stays inside the range where
;       Racket's exact integers are still fixnums.
; note: the per-byte read goes through Arc's own ($ ...) escape, which is the language's documented
;       way to reach its host; arc.arc itself uses it for the vector case of `len`. Without it the
;       generic reference path costs about 11 us per byte (measured), which over fifty million bytes
;       would be the whole task. A `,` inside `$` splices an Arc expression back into the Racket
;       form, so `,buf` is the chunk just read.

(with (total 0)
  (= port (infile "data.bin"))

  (loop (buf (readbytes 1048576 port))
    (when buf
      (with (nb ($ (bytes-length ,buf)) s 0)
        (loop (i 0)
          (when (< i nb)
            (= s (+ s ($ (bytes-ref ,buf ,i))))
            (recur (+ i 1))))
        (= total (mod (+ total s) 4294967296))
        (recur (readbytes 1048576 port)))))

  (close port)
  (prn total))
