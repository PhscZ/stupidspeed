;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 01_branches.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; Four counters over a hundred million iterations, the same nested if/else chain as every
;; other row. loop/recur is Clojure's plain imperative loop.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [i (long 0) a (long 0) b (long 0) c (long 0) d (long 0)]
    (if (< i (long 100000000))
      (if (zero? (rem i 3))
        (recur (inc i) (inc a) b c d)
        (if (zero? (rem i 5))
          (recur (inc i) a (inc b) c d)
          (if (zero? (rem i 7))
            (recur (inc i) a b (inc c) d)
            (recur (inc i) a b c (inc d)))))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println a b c d)))))

(-main)
