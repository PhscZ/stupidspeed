;; task 05 alloc_churn — expected output: 1274991808
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 05_alloc_churn.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: unchecked-byte, not byte: Clojure's checked byte coercion throws above 127 and the
;;       value written spans the full 0..255 range.
;; note: the dropped 64-byte arrays really do become garbage here, the same reachability
;;       line the Java and C rows draw.

;; Ten million 64-byte buffers, each dropped into one of 256 slots so the buffer it replaces
;; becomes garbage for the collector -- the same reachability line the C and Java rows draw.
;; The running total adds v, the value written, exactly as the Java row does.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [slots (object-array 256)]
    (loop [i (long 0) total (long 0)]
      (if (< i (long 10000000))
        (let [v (int (rem i 256))
              buf (byte-array 64)]
          (aset buf 0 (unchecked-byte v))
          (aset slots v buf)
          (recur (inc i) (unchecked-add total (long v))))
        (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
            (println total))))))

(-main)
