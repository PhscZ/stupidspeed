;; task 14 file_read — expected output: 1937768448
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" 14_file_read.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
;; note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
;;       up; the running total is reduced mod 2^32 as it goes so it stays inside the 2^53 range
;;       where a double is exact. Bytes are unsigned via (bit-and b 0xFF), because a JVM byte is
;;       signed and the file holds the full 0..255 range.
(import '(java.io FileInputStream))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [buf (byte-array (* 1024 1024))
        total (loop [pass (long 0)
                     total (long 0)]
                (if (< pass 8)
                  (recur (inc pass)
                         (with-open [in (FileInputStream. "data.bin")]
                           (loop [t total]
                             (let [n (.read in buf)]
                               (if (neg? n)
                                 t
                                 (recur (rem (loop [i (long 0) tt t]
                                               (if (< i (long n))
                                                 (recur (inc i)
                                                        (unchecked-add tt (long (bit-and (aget buf i) 0xFF))))
                                                 tt))
                                             4294967296)))))))
                  total))]
    (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
    (println (rem total 4294967296))))

(-main)
