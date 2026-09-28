;; task 15 file_write — expected output: 52428800
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" 15_file_write.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
;; note: the 1 MiB buffer is written 50 times, then flushed and committed with
;;       getFD().sync(), the same call the Java row makes. FileOutputStream has no fsync of its
;;       own, so the commit goes through the file descriptor.
;; note: unchecked-byte, not byte: Clojure's checked byte coercion throws on anything above
;;       127, and the buffer holds the full 0..255 range.
(import '(java.io FileOutputStream))

(defn -main []
  (let [len (int (* 1024 1024))
        buf (byte-array len)]
    (dotimes [i len]
      (aset buf i (unchecked-byte (rem i 256))))
    (with-open [out (FileOutputStream. "out.bin")]
      (dotimes [i 50]
        (.write out buf))
      (.flush out)
      (.sync (.getFD out)))
    (println (* 50 len))))

(-main)
