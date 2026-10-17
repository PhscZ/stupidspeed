;; task 13 matrix_mul — expected output: 599995000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 13_matrix_mul.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
;; column of B. Reordering would be faster, which is the point.
(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [n (long 500)
        elems (unchecked-multiply n n)
        a (long-array elems)
        b (long-array elems)
        c (long-array elems)]
    (dotimes [i n]
      (dotimes [j n]
        (let [idx (unchecked-add (unchecked-multiply i n) j)]
          (aset a idx (rem (unchecked-add i j) 7))
          (aset b idx (rem (unchecked-multiply i j) 5)))))
    (dotimes [r n]
      (dotimes [col n]
        (loop [k (long 0) acc (long 0)]
          (if (< k n)
            (recur (inc k)
                   (unchecked-add acc
                                  (unchecked-multiply (aget a (unchecked-add (unchecked-multiply r n) k))
                                                      (aget b (unchecked-add (unchecked-multiply k n) col)))))
            (aset c (unchecked-add (unchecked-multiply r n) col) acc)))))
    (loop [e (long 0) total (long 0)]
      (if (< e elems)
        (recur (inc e) (unchecked-add total (aget c e)))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
