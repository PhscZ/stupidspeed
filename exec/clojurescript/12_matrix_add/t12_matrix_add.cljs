;; task 12 matrix_add — expected output: 999000000
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t12-matrix-add    run: <root>/tools/nodejs/node.exe prog.js
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
;; note: `long-array` exists in ClojureScript only for source compatibility -- it returns a plain
;;       JavaScript Array, so every element is a boxed double. Float64Array is the real primitive
;;       array on this target and is the honest analogue of the JVM row's long[]. Every value here
;;       (i+j, i-j and their sums) is a small integer, and the total 999000000 is exact in a double.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [n 1000
        elems (* n n)
        a (js/Float64Array. elems)
        b (js/Float64Array. elems)
        c (js/Float64Array. elems)]
    (dotimes [i n]
      (dotimes [j n]
        (let [idx (+ (* i n) j)]
          (aset a idx (+ i j))
          (aset b idx (- i j)))))
    (dotimes [p n]
      (dotimes [q n]
        (let [idx (+ (* p n) q)]
          (aset c idx (+ (aget a idx) (aget b idx))))))
    (loop [k 0 total 0]
      (if (< k elems)
        (recur (inc k) (+ total (aget c k)))
        (do (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
            (println total))))))

(-main)
