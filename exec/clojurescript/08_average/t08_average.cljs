;; task 08 average — expected output: 0.498046875
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t08-average    run: <root>/tools/nodejs/node.exe prog.js
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
;; note: a ClojureScript number is a JavaScript double, so the accumulator and the readings are the
;;       same IEEE-754 doubles the JVM row uses, and the total is far below 2^53 so the sum is exact
;;       and the digits do not depend on the order of addition. The JVM row's Double/toString is not
;;       needed: ClojureScript's `str` on a number is JavaScript's own number-to-string, which prints
;;       the same shortest round-tripping form.

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (loop [i 0 total 0.0]
    (if (< i 100000000)
      (recur (inc i) (+ total (/ (rem i 256) 256.0)))
      (do (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
          (println (/ total 100000000.0))))))

(-main)
