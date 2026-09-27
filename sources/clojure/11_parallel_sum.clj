;; task 11 parallel_sum — expected output: 7500000075000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" 11_parallel_sum.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
;; note: four real java.lang.Thread objects over fixed ranges, the same shape as the Java row.
;;       Raw interop rather than `future`, because future's executor threads are non-daemon and
;;       the JVM would not exit without an explicit (shutdown-agents) -- a timed run would hang.
;;       The ^Runnable and ^Thread hints keep every interop call reflection-free.
;; note: the accumulator is a primitive long; 7500000075000000 is past 2^31 but far inside long.
(set! *unchecked-math* true)

(def ^:const SPAN 25000000)

(defn work ^long [^long t]
  (let [start (unchecked-multiply t (long SPAN))
        end (unchecked-add start (long SPAN))]
    (loop [i start acc (long 0)]
      (if (< i end)
        (recur (inc i)
               (unchecked-add acc
                              (case (int (rem i 4))
                                0 1
                                1 i
                                2 (unchecked-multiply 2 i)
                                3 (unchecked-multiply 3 i))))
        acc))))

(defn -main []
  (let [results (long-array 4)
        threads (object-array 4)]
    (dotimes [t 4]
      (let [id (long t)]
        (aset threads t (Thread. ^Runnable (fn [] (aset results id (work id)))))))
    (dotimes [t 4]
      (.start ^Thread (aget threads t)))
    (dotimes [t 4]
      (.join ^Thread (aget threads t)))
    (loop [t (long 0) total (long 0)]
      (if (< t (long 4))
        (recur (inc t) (unchecked-add total (aget results t)))
        (println total)))))

(-main)
