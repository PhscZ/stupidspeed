;; task 09 fib_recursive — expected output: 102334155
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 09_fib_recursive.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; Naive fib(40): about 331 million calls, so this measures the call path itself. A plain
;; self-recursive defn -- each level is a real function call, not a loop.
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
