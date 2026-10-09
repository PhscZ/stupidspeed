;; task 11 parallel_sum — expected output: 7500000075000000
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t11-parallel-sum    run: <root>/tools/nodejs/node.exe prog.js
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
;; note: correct-answer-no-speedup. This is a change from sources/clojure/11_parallel_sum.clj, which
;;       spawns four java.lang.Threads: ClojureScript has no java.lang.Thread, and no thread type of
;;       its own -- a ClojureScript program is single-threaded JavaScript. The four quarters are
;;       computed serially in the caller instead, with the JVM row's work function, its four fixed
;;       ranges and its summation, so the answer is the same 7500000075000000 and only the overlap is
;;       missing. Same disposition as the wasm rows whose runtime has no threads. (The javascript row
;;       can do better only because it calls node's worker_threads API directly; that is node's
;;       threading, not ClojureScript's.)
;; note: the JVM row's `(set! *unchecked-math* true)`, its ^long hints and its unchecked-* calls are
;;       JVM primitive machinery and are dropped here; see 01_branches.cljs for why. The total is
;;       under 2^53, and every partial sum is smaller than it, so doubles hold it exactly.

(def ^:private SPAN 25000000)

(defn ^:private work [t]
  (let [start (* t SPAN)
        end (+ start SPAN)]
    (loop [i start acc 0]
      (if (< i end)
        (recur (inc i)
               (+ acc
                  (case (rem i 4)
                    0 1
                    1 i
                    2 (* 2 i)
                    3 (* 3 i))))
        acc))))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [results (js/Float64Array. 4)]
    (dotimes [t 4]
      (aset results t (work t)))
    (loop [t 0 total 0]
      (if (< t 4)
        (recur (inc t) (+ total (aget results t)))
        (do (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
            (println total))))))

(-main)
