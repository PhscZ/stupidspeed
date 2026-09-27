;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 01_branches.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; Four counters over a hundred million iterations, the same nested if/else chain as every
;; other row. loop/recur is Clojure's plain imperative loop; the four counters are primitive
;; longs because every binding is hinted and the arithmetic is unchecked.
(defn -main []
  (loop [i (long 0) a (long 0) b (long 0) c (long 0) d (long 0)]
    (if (< i (long 100000000))
      (if (zero? (rem i 3))
        (recur (inc i) (inc a) b c d)
        (if (zero? (rem i 5))
          (recur (inc i) a (inc b) c d)
          (if (zero? (rem i 7))
            (recur (inc i) a b (inc c) d)
            (recur (inc i) a b c (inc d)))))
      (println a b c d))))

(-main)
