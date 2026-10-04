;; task 07 string_append — expected output: 250000
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" clojure.main 07_string_append.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
(set! *unchecked-math* true)

;; Plain string concatenation 250000 times: str allocates a new string and copies the old
;; one on every append, so the work is quadratic. Deliberately no StringBuilder.
(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [i (long 0) text ""]
    (if (< i (long 250000))
      (recur (inc i) (str text "x"))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println (.length text))))))

(-main)
