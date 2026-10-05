;; task 02 switch_case — expected output: 7500000075000000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 02_switch_case.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: case on (rem i 4) is a real Clojure `case`, which babashka compiles to a hash-based
;;       dispatch on the constant keys — the closest thing to a jump table here.

;; case on (rem i 4) with a long accumulator. The total 7500000075000000 is past 2^31, which
;; is why the accumulator is a long and the arithmetic is unchecked.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [i (long 0) acc (long 0)]
    (if (< i (long 100000000))
      (recur (inc i)
             (unchecked-add acc
                            (case (int (rem i 4))
                              0 1
                              1 i
                              2 (unchecked-multiply 2 i)
                              3 (unchecked-multiply 3 i))))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println acc)))))

(-main)
