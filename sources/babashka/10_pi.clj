;; task 10 pi — expected output: 4470
;; build: none (babashka interprets the file; there is no build step)
;; run: C:\stupidspeed\tools\babashka\bb.exe 10_pi.clj
;; timing: (System/nanoTime), a monotonic clock; TIME_MS goes to stderr
;; note: babashka is Clojure on SCI (a Clojure interpreter) packaged as a GraalVM native
;;       image — a different row from the JVM one in sources/clojure/. There is no JIT and
;;       no inliner, so every form below is interpreted as written.
;; note: (set! *unchecked-math* true) and the ^long hints are carried over from the Clojure
;;       row for parity. SCI does not use the hints for primitive arithmetic the way the JVM
;;       compiler does, but the unchecked-* operators still wrap instead of throwing.
;; note: babashka inherits Clojure's exact arbitrary-precision integers, so unlike most rows
;;       this one does NOT hand-roll base-1e9 limbs. The promoting operators +' and *' compute
;;       in a long and widen to a BigInt only on overflow, so they are exact at any size and
;;       still cheap while the spigot state is small. Plain + and * throw on long overflow in
;;       babashka, which is why the promoting forms are used here.
;; note: the same Gibbons unbounded spigot as every other row, same operation order. quot does
;;       a real bignum division here rather than the repeated subtraction the hand-rolled rows
;;       use, which is exactly the advantage a built-in bignum buys.

;; Gibbons' unbounded spigot over the built-in exact integers. n stays a long because it is
;; always a single digit; q, r and t grow to about 16000 bits.
(set! *unchecked-math* true)

(def ^:private __t0 (volatile! 0))

(defn -main []
  (vreset! __t0 (System/nanoTime))
  (loop [q 1N r 0N t 1N
         k (long 1) l (long 3) n (long 3)
         produced (long 0) sum (long 0)]
    (if (< produced (long 1000))
      (let [u (+' (*' (long 4) q) r)
            v (*' (inc n) t)]
        (if (< u v)
          (let [u2 (*' (long 10) (+' (*' (long 3) q) r))
                next-n (long (- (quot u2 t) (*' (long 10) n)))
                r2 (*' (long 10) (- r (*' n t)))]
            (recur (*' (long 10) q) r2 t k l next-n (inc produced) (unchecked-add sum n)))
          (let [u3 (+' (*' q (+ (long 2) (* (long 7) k))) (*' r l))
                next-n (long (quot u3 (*' t l)))
                r2 (*' (+' (*' (long 2) q) r) l)]
            (recur (*' q k) r2 (*' t l) (inc k) (+ l (long 2)) next-n produced sum))))
      (do (.println System/err (str "TIME_MS=" (/ (- (System/nanoTime) (long @__t0)) 1000000.0)))
          (println sum)))))

(-main)
