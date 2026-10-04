;; task 13 matrix_mul — expected output: 599995000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 13_matrix_mul.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; The plain i, j, k triple loop in that order on flat row-major arrays, so the k loop walks a
;; column of B. Reordering would be faster, which is the point.
(set! *unchecked-math* true)

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
