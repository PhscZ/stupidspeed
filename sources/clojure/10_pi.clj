;; task 10 pi — expected output: 4470
;; build: none (clojure.main compiles the file to bytecode on every run)
;; run: java -cp "<clojure>\clojure-1.12.0.jar;<clojure>\spec.alpha-0.5.238.jar;<clojure>\core.specs.alpha-0.4.74.jar" 10_pi.clj
;; note: <clojure> is the directory holding the three Clojure runtime jars. Clojure needs
;;       no build step: clojure.main loads the file and compiles it as it runs, so the
;;       compile time is inside the measured number.
;; note: (set! *unchecked-math* true) plus ^long hints is what keeps these loops on
;;       primitive longs. Without them every arithmetic step boxes, which costs roughly
;;       an order of magnitude -- the unchecked ops are the same ones the Java row gets
;;       from plain long arithmetic.
;; note: Clojure has exact arbitrary-precision integers built in, so unlike most rows this
;;       one does NOT hand-roll base-1e9 limbs. The promoting operators +' and *' compute in a
;;       primitive long and widen to a BigInt only on overflow, so they are exact at any size
;;       and still cheap while the spigot state is small. ClojureScript has none of this.
;; note: the same Gibbons unbounded spigot as every other row, same operation order. quot does
;;       a real bignum division here rather than the repeated subtraction the hand-rolled rows
;;       use, which is exactly the advantage a built-in bignum buys.
(set! *unchecked-math* true)

;; Gibbons' unbounded spigot over Clojure's built-in exact integers. n stays a primitive long
;; because it is always a single digit; q, r and t grow to about 16000 limbs.
(defn -main []
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
          (let [u3 (+' (*' q (+ (long 1) (* (long 7) k))) (*' r l))
                next-n (long (quot u3 (*' t l)))
                r2 (*' (+' (*' (long 2) q) r) l)]
            (recur (*' q k) r2 (*' t l) (inc k) (+ l (long 2)) next-n produced sum))))
      (println sum))))

(-main)
