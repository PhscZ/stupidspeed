;; task 08 average — expected output: 0.498046875
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 08_average.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; A hundred million readings, each a multiple of 1/256, accumulated in a primitive double.
;; The total is far below 2^53, so the sum is exact and the digits do not depend on the order
;; of addition. Double/toString is what keeps the output to the one expected line.
(defn -main []
  (loop [i (long 0) total (double 0.0)]
    (if (< i (long 100000000))
      (recur (inc i) (unchecked-add total (/ (double (rem i 256)) 256.0)))
      (println (Double/toString (/ total 100000000.0))))))

(-main)
