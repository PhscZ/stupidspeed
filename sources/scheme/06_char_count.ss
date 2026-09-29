;; task 06 char_count — expected output: 10000000
;; build: none (scheme --script compiles the script on every run; the boot-file load and
;;        the compile are part of the measured time)
;; run: scheme --optimize-level 3 --script 06_char_count.ss
;; note: the 100 MB text is built once by doubling the ten-character block inside one
;;       preallocated string, which is O(log n) copies rather than a hundred million
;;       appends, and then scanned one character at a time. Building it by appending in a
;;       loop would make the build the benchmark, which the task forbids.
;; note: string-ref yields a character, and char=? is the comparison, so there is no
;;       integer/character punning to do. The text is 100000000 characters, the same 100 MB
;;       the other rows build.

(define n 100000000)
(define text (make-string n #\a))
(string-copy! "abcdefghij" 0 text 0 10)
(let build ([k 10])
  (when (fx< k n)
    (string-copy! text 0 text k (fxmin k (fx- n k)))
    (build (fx* 2 k))))

(let loop ([i 0] [count 0])
  (if (fx= i n)
      (begin (display count) (newline))
      (let ([ch (string-ref text i)])
        (loop (fx+ i 1)
              (cond [(char=? ch #\a) count]
                    [(char=? ch #\e) count]
                    [(char=? ch #\h) (fx+ count 1)]
                    [else count])))))
