;; task 08 average — expected output: 0.498046875
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 08_average.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; A hundred million readings, each a multiple of 1/256, accumulated in a double. The total is
;; far below 2^53, so the sum is exact and the digits do not depend on the order of addition.
;; Double/toString is what keeps the output to the one expected line.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [i (long 0) total (double 0.0)]
    (if (< i (long 100000000))
      (recur (inc i) (unchecked-add total (/ (double (rem i 256)) 256.0)))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println (Double/toString (/ total 100000000.0)))))))

(-main)
