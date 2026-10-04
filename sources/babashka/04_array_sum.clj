;; task 04 array_sum — expected output: 499999500000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 04_array_sum.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; A million-element primitive long array, filled and then summed in two separate passes, the
;; same shape as the C row. The total 499999500000 is past 2^31, so the sum is a long.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [n (long 1000000)
        arr (long-array n)]
    (dotimes [i n]
      (aset arr i (long i)))
    (loop [i (long 0) total (long 0)]
      (if (< i n)
        (recur (inc i) (unchecked-add total (aget arr i)))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
