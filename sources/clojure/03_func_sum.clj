;; task 03 func_sum — expected output: 100000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 03_func_sum.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; A hundred million calls to a one-line function. add-one is hinted so the call stays on
;; primitive longs instead of boxing, but it is still a real Clojure var invocation -- the
;; JIT may inline it, which is the same caveat the Java row records for this task.
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
