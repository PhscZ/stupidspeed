;; task 01 branches — expected output: 33333334 13333333 7619048 45714285
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t01-branches    run: <root>/tools/nodejs/node.exe prog.js
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
;;       JVM primitive machinery: on the JVM they are what keeps a loop on primitive longs instead of
;;       boxing every step. ClojureScript numbers already are JavaScript doubles, so there is nothing
;;       to keep them out of and the calls would only add a call per iteration. They are dropped
;;       here; the loops, the ranges, the order of operations and the printed answer are unchanged.
;; note: the clock is cljs.core/system-time, ClojureScript's own host clock -- performance.now() under
;;       node -- which already reads in milliseconds. The JVM row divides System/nanoTime by 1e6.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (loop [i 0 a 0 b 0 c 0 d 0]
    (if (< i 100000000)
      (if (zero? (rem i 3))
        (recur (inc i) (inc a) b c d)
        (if (zero? (rem i 5))
          (recur (inc i) a (inc b) c d)
          (if (zero? (rem i 7))
            (recur (inc i) a b (inc c) d)
            (recur (inc i) a b c (inc d)))))
      (do (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
          (println a b c d)))))

(-main)
