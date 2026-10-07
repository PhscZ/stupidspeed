;; task 02 switch_case — expected output: 7500000075000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 02_switch_case.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; case on (rem i 4) with a primitive long accumulator. The total 7500000075000000 is past
;; 2^31, which is why the accumulator is a long and the arithmetic is unchecked.
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
