;; task 10 pi — expected output: 4470
;; build: java -cp "<root>/tools/clojurescript/cljs.jar;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile t10-pi    run: <root>/tools/nodejs/node.exe prog.js
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
;; note: this is a change from sources/clojure/10_pi.clj. ClojureScript has no exact
;;       arbitrary-precision integer type at all: `1N` reads as an ordinary double and the promoting
;;       operators +' and *' do not exist (they are not in cljs.core). The 1000 digits of pi need
;;       thousands of digits of precision, so the spigot cannot run on ClojureScript numbers. The
;;       file therefore reaches JavaScript's native BigInt through js* interop and runs exactly the
;;       algorithm the javascript row runs on that same BigInt -- same operation order, same
;;       truncating division corrected to a floor, same final digit sum. js* emits the JavaScript
;;       source verbatim, which is how a ClojureScript file talks to a host type the language has
;;       no reader syntax for. ClojureScript's own numbers are still what counts the digits and sums
;;       them: the sum is 4470, far inside a double.
;; note: the JVM row's `(set! *unchecked-math* true)`, its ^long hints and its unchecked-* calls are
;;       JVM primitive machinery and are dropped here; see 01_branches.cljs for why.
;; Gibbons' unbounded spigot on native BigInt; the first 1000 digits it emits are summed, and
;; that includes the leading 3. The digits themselves are never printed.

(def ^:private DIGITS 1000)

;; ---- native BigInt through js*: ClojureScript has no bignum of its own -------------------
(defn ^:private big [x] (js* "BigInt(~{})" x))
(defn ^:private b+ [a b] (js* "(~{} + ~{})" a b))
(defn ^:private b- [a b] (js* "(~{} - ~{})" a b))
(defn ^:private b* [a b] (js* "(~{} * ~{})" a b))
(defn ^:private bdiv [a b] (js* "(~{} / ~{})" a b))
(defn ^:private brem [a b] (js* "(~{} % ~{})" a b))
(defn ^:private blt [a b] (js* "(~{} < ~{})" a b))
(defn ^:private bnum [a] (js* "Number(~{})" a))

;; BigInt division truncates toward zero; the spigot's quotients are floor divisions.
(defn ^:private floor-div [a b]
  (let [q (bdiv a b)
        rem (brem a b)]
    (if (and (not (zero? (bnum rem))) (blt rem (big 0)))
      (b- q (big 1))
      q)))

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (system-time))
  (let [sum (loop [q (big 1) r (big 0) t (big 1) k (big 1) n (big 3) l (big 3)
                   sum 0 emitted 0]
              (if (< emitted DIGITS)
                (if (blt (b- (b+ (b* (big 4) q) r) t) (b* n t))
                  ;; n is the next digit of pi.
                  (let [nq (b* (big 10) q)
                        nr (b* (big 10) (b- r (b* n t)))
                        nn (b- (floor-div (b* (big 10) (b+ (b* (big 3) q) r)) t)
                               (b* (big 10) n))]
                    (recur nq nr t k nn l (+ sum (bnum n)) (inc emitted)))
                  (let [nq (b* q k)
                        nr (b* (b+ (b* (big 2) q) r) l)
                        nt (b* t l)
                        nn (floor-div (b+ (b* q (b+ (big 7) (b* (big 2) k))) (b* r l)) nt)
                        nl (b+ l (big 2))]
                    (recur nq nr nt (b+ k (big 1)) nn nl sum emitted)))
                sum))]
    (.write js/process.stderr (str "TIME_MS=" (- (system-time) @__t0) "\n"))
    (println sum)))

(-main)
