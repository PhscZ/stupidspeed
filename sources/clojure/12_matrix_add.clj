;; task 12 matrix_add — expected output: 999000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 12_matrix_add.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; Three flat 1000x1000 primitive long arrays, row-major, filled and added with plain
;; index arithmetic. The total fits in a long.
(defn -main []
  (let [n (long 1000)
        elems (unchecked-multiply n n)
        a (long-array elems)
        b (long-array elems)
        c (long-array elems)]
    (dotimes [i n]
      (dotimes [j n]
        (let [idx (unchecked-add (unchecked-multiply i n) j)]
          (aset a idx (unchecked-add i j))
          (aset b idx (unchecked-subtract i j)))))
    (dotimes [p n]
      (dotimes [q n]
        (let [idx (unchecked-add (unchecked-multiply p n) q)]
          (aset c idx (unchecked-add (aget a idx) (aget b idx))))))
    (loop [k (long 0) total (long 0)]
      (if (< k elems)
        (recur (inc k) (unchecked-add total (aget c k)))
        (println total)))))

(-main)
