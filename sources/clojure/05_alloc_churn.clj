;; task 05 alloc_churn — expected output: 1274991808
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 05_alloc_churn.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; Ten million 64-byte buffers, each dropped into one of 256 slots so the buffer it replaces
;; becomes garbage for the collector -- the same reachability line the C and Java rows draw.
;; The running total adds v, the value written, exactly as the Java row does.
(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [slots (object-array 256)]
    (loop [i (long 0) total (long 0)]
      (if (< i (long 10000000))
        (let [v (int (rem i 256))
              buf (byte-array 64)]
          (aset buf 0 (byte v))
          (aset slots v buf)
          (recur (inc i) (unchecked-add total (long v))))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
