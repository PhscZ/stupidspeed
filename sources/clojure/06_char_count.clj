;; task 06 char_count — expected output: 10000000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 06_char_count.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; The 100 MB text is built once with String.repeat, the same call the Java row uses, and then
;; scanned one character at a time with charAt. Nothing is cached between characters.
(defn -main []
  (let [text (.repeat "abcdefghij" (int 10000000))
        len (long (.length text))]
    (loop [i (long 0) count (long 0)]
      (if (< i len)
        (recur (inc i)
               (if (= (.charAt text (int i)) \h)
                 (unchecked-inc count)
                 count))
        (println count)))))

(-main)
