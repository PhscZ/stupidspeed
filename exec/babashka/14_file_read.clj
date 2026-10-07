;; task 14 file_read — expected output: 2389704704
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 14_file_read.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: data.bin is read from the working directory in 1 MiB chunks and every byte is added
;;       up; the running total is reduced mod 2^32 as it goes so it stays inside the 2^53
;;       range where a double would still be exact, although it is a long here. Bytes are
;;       unsigned via (bit-and b 0xFF), because the byte-array holds signed bytes and the file
;;       covers the full 0..255 range.

(import '(java.io FileInputStream))

(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [buf (byte-array (* 1024 1024))]
    (with-open [in (FileInputStream. "data.bin")]
      (loop [total (long 0)]
        (let [n (.read in buf)]
          (if (neg? n)
            (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
                (println (rem total 4294967296)))
            (recur (rem (loop [i (long 0) t total]
                          (if (< i (long n))
                            (recur (inc i)
                                   (unchecked-add t (long (bit-and (aget buf i) 0xFF))))
                            t))
                        4294967296))))))))

(-main)
