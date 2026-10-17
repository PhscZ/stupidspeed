;; task 04 array_sum — expected output: 599999940000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 04_array_sum.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; A ten-million-element primitive long array, filled once and then summed twelve times, the
;; same shape as the C row. The total 599999940000000 is past 2^31, so the sum is a long.
(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [n (long 10000000)
        arr (long-array n)]
    (dotimes [i n]
      (aset arr i (long i)))
    (loop [r (long 0) total (long 0)]
      (if (< r 12)
        (recur (inc r)
               (loop [i (long 0) acc total]
                 (if (< i n)
                   (recur (inc i) (unchecked-add acc (aget arr i)))
                   acc)))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
