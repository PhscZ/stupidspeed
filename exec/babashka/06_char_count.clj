;; task 06 char_count — expected output: 10000000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 06_char_count.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; The 100 MB text is built once with String.repeat, the same call the Java row uses, so the
;; build is not part of the scan; then it is scanned one character at a time with charAt.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [text (.repeat "abcdefghij" (int 10000000))
        len (long (.length text))]
    (loop [i (long 0) count (long 0)]
      (if (< i len)
        (recur (inc i)
               (if (= (.charAt text (int i)) \h)
                 (unchecked-inc count)
                 count))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println count))))))

(-main)
