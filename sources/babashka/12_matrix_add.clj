;; task 12 matrix_add — expected output: 999000000
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 12_matrix_add.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.

;; Three flat 1000x1000 primitive long arrays, row-major, filled and added with plain index
;; arithmetic. The total fits in a long.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
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
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
