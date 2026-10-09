;; task 13 matrix_mul — expected output: 599995000
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t13-matrix-mul    run: <root>/tools/nodejs/node.exe prog.js
;; note: the ClojureScript row; the JVM sibling is sources/clojure/. Built with the ClojureScript
;;       release jar (ClojureScript 1.11.132, tools/clojurescript/cljs.jar -- it bundles Clojure,
;;       the Closure compiler and cljs/core.cljs) and run under tools/nodejs/node.exe (node 22.11.0).
;;       Unlike the JVM row this one has a build step: cljs.main compiles the .cljs to JavaScript
;;       ahead of time, so the compile time is not inside the measured number. The classpath's `.`
;;       is the cell's own directory, which is where the .cljs source sits.
;; note: ClojureScript requires the namespace to correspond to the file name, so each file carries an
;;       `(ns ...)` header named after itself and the file is named to match: t01_branches.cljs holds
;;       (ns t01-branches), the `t` because a namespace symbol cannot begin with a digit. That
;;       single-segment namespace is what the :single-segment-namespace warning is silenced for. The
;;       file ends with a plain `(-main)` call, the same shape the JVM row uses. The `tNN_` prefix is
;;       ClojureScript's rule, not this row's; the JVM row's files are plain 01_branches.clj.
;; note: the JVM row's `(set! *unchecked-math* true)`, its ^long hints and its unchecked-* calls are
;;       JVM primitive machinery and are dropped here; see 01_branches.cljs for why.
;; note: Float64Array stands in for the JVM row's long[]; see 12_matrix_add.cljs. Every product is at
;;       most 6*4 and every row sum at most 500*24, and the total 599995000, all exact in a double.
;;       The plain i, j, k triple loop in that order is kept, so the k loop still walks a column of
;;       b and the cache-unfriendly access pattern this task is about is preserved.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [n 500
        elems (* n n)
        a (js/Float64Array. elems)
        b (js/Float64Array. elems)
        c (js/Float64Array. elems)]
    (dotimes [i n]
      (dotimes [j n]
        (let [idx (+ (* i n) j)]
          (aset a idx (rem (+ i j) 7))
          (aset b idx (rem (* i j) 5)))))
    (dotimes [r n]
      (dotimes [col n]
        (loop [k 0 acc 0]
          (if (< k n)
            (recur (inc k)
                   (+ acc (* (aget a (+ (* r n) k))
                             (aget b (+ (* k n) col)))))
            (aset c (+ (* r n) col) acc)))))
    (loop [e 0 total 0]
      (if (< e elems)
        (recur (inc e) (+ total (aget c e)))
        (do (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
            (println total))))))

(-main)
