;; task 09 fib_recursive — expected output: 102334155
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 09_fib_recursive.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: babashka has a large native stack, so the ~40-deep recursion is nowhere near its
;;       limit; no trampolining or explicit stack is needed.

;; Naive fib(40): about 331 million calls, so this measures the call path itself. A plain
;; self-recursive defn -- each level is a real function call, not a loop.
(set! *unchecked-math* true)

(defn fib ^long [^long n]
  (if (< n (long 2))
    n
    (unchecked-add (fib (unchecked-dec n)) (fib (unchecked-subtract n 2)))))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [result (fib (long 40))]
    (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
        (println result))))

(-main)
