;; task 15 file_write — expected output: 52428800
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 15_file_write.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: the 1 MiB buffer is written 50 times, then flushed and committed. The JVM row uses
;;       FileDescriptor.sync(), but babashka's reflection allow-list rejects .sync on
;;       FileDescriptor ("Method sync ... not allowed"), so the commit goes through the
;;       channel instead: FileChannel.force(true) is fsync plus a metadata flush.
;; note: unchecked-byte, not byte: Clojure's checked byte coercion throws on anything above
;;       127, and the buffer holds the full 0..255 range.

(import '(java.io FileOutputStream))

(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (let [len (int (* 1024 1024))
        buf (byte-array len)]
    (dotimes [i len]
      (aset buf i (unchecked-byte (rem i 256))))
    (with-open [out (FileOutputStream. "out.bin")]
      (dotimes [i 50]
        (.write out buf))
      (.flush out)
      (.force (.getChannel out) true))
    (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
        (println (* 50 len)))))

(-main)
