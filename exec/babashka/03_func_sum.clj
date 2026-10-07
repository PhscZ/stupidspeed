;; task 03 func_sum — expected output: 100000000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 03_func_sum.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: babashka has no no-inline marker because it has no inliner: SCI evaluates the call
;;       to add-one on every iteration, so the hundred million calls really happen. The
;;       helper therefore stays in this one file, as the Clojure row also does.

;; A hundred million calls to a one-line function.
(set! *unchecked-math* true)

(defn add-one ^long [^long n]
  (unchecked-add n (long 1)))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [i (long 0) value (long 0)]
    (if (< i (long 100000000))
      (recur (inc i) (add-one value))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println value)))))

(-main)
