;; task 14 file_read — expected output: 484442112
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

(defn -main []
  (let [buf (byte-array (* 1024 1024))]
    (with-open [in (FileInputStream. "data.bin")]
      (loop [total (long 0)]
        (let [n (.read in buf)]
          (if (neg? n)
            (println (rem total 4294967296))
            (recur (rem (loop [i (long 0) t total]
                          (if (< i (long n))
                            (recur (inc i)
                                   (unchecked-add t (long (bit-and (aget buf i) 0xFF))))
                            t))
                        4294967296))))))))

(-main)
