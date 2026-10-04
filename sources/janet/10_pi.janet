# task 10 pi — expected output: 4470
# build: none — `janet` compiles the script to bytecode and runs it on every invocation
# run: janet 10_pi.janet
# note: Janet has no big-integer type. Its only numeric type is the IEEE 754 double, and the
#       Integer Types module is four boxed abstracts (int/s64, int/u64, int/to-number,
#       int/to-bytes) with no arithmetic, so this is the C reference's hand-written big
#       integer: sign-magnitude, little-endian limbs, base 1e9, with add, subtract, multiply
#       by a small integer, and a quotient that comes out of repeated subtraction because the
#       spigot only ever asks for one decimal digit at a time. Gibbons' unbounded spigot is
#       the same loop, step for step; only the sum of the 1000 digits is printed.
# note: the limbs are doubles, which is the only numeric type wide enough. A limb times the
#       spigot's multiplier is at most 999999999 * 232471, about 2.3e14, and a double is
#       exact to 2^53 = 9.0e15, so every product and every carry is exact. There is no `mod`
#       that is safe on numbers this size in general, so the carry is
#       (math/floor (/ p 1000000000)) and the remainder is p - carry * 1000000000; the
#       division is exact enough that the floor never lands one below the true quotient,
#       because p is an integer and its distance to the next multiple of 1e9 is at least
#       1e-9, while the rounding error at 2.3e14 is below 2e-11.
# note: each big integer is a three-element array — the limb array, the limb count, and the
#       sign — and the helper functions mutate it in place, mirroring the C reference's
#       Big struct. The state is about 1248 limbs at 1000 digits.
# note: the reduced-scale digit sums, computed independently with mpmath, are 100 -> 471,
#       200 -> 897, 400 -> 1753, 800 -> 3588, 1600 -> 7269; they are the evidence that the
#       arithmetic is right at every scale.

# timing: os/clock is Janet's monotonic clock, in seconds as a double; TIME_MS goes to
#         stderr with eprintf and stdout is unchanged.
(def ss-t0 (os/clock))
(defn ss-report [] (eprintf "TIME_MS=%.3f\n" (* 1000 (- (os/clock) ss-t0))))

(def BASE 1000000000)
(def BASEF 1000000000.0)

(defn big-new [] @[@[] 0 0])

(defn big-set [x v]
  (def limbs (x 0))
  (array/clear limbs)
  (var vv v)
  (while (> vv 0)
    (def cy (math/floor (/ vv BASEF)))
    (array/push limbs (- vv (* cy BASEF)))
    (set vv cy))
  (put x 1 (length limbs))
  (put x 2 0))

(defn big-copy [d s]
  (def dl (d 0))
  (def sl (s 0))
  (array/clear dl)
  (def n (s 1))
  (for i 0 n
    (array/push dl (sl i)))
  (put d 1 n)
  (put d 2 (s 2)))

(defn big-trim [x]
  (def limbs (x 0))
  (var c (x 1))
  (while (and (> c 0) (= 0 (limbs (- c 1))))
    (-- c))
  (put x 1 c)
  (if (= c 0)
    (put x 2 0)))

(defn cmp-mag [a b]
  (def an (a 1))
  (def bn (b 1))
  (if (not= an bn)
    (if (< an bn) -1 1)
    (do
      (var res 0)
      (for i 0 an
        (def j (- (- an 1) i))
        (def av ((a 0) j))
        (def bv ((b 0) j))
        (if (not= av bv)
          (do
            (set res (if (< av bv) -1 1))
            (break))))
      res)))

(defn big-cmp [a b]
  (def an (a 2))
  (def bn (b 2))
  (if (not= an bn)
    (if (not= an 0) -1 1)
    (do
      (def c (cmp-mag a b))
      (if (not= an 0) (- c) c))))

(defn add-mag [r a b]
  (def an (a 1))
  (def bn (b 1))
  (def c (if (> bn an) bn an))
  (def rl (r 0))
  (def al (a 0))
  (def bl (b 0))
  (var carry 0)
  (for i 0 c
    (var s carry)
    (if (< i an) (+= s (al i)))
    (if (< i bn) (+= s (bl i)))
    (if (>= s BASE)
      (do (set s (- s BASE)) (set carry 1))
      (set carry 0))
    (if (< i (length rl)) (put rl i s) (array/push rl s)))
  (if (not= carry 0)
    (do
      (if (< c (length rl)) (put rl c carry) (array/push rl carry))
      (put r 1 (+ c 1)))
    (put r 1 c))
  (put r 2 0))

(defn sub-mag [r a b]
  (def an (a 1))
  (def bn (b 1))
  (def rl (r 0))
  (def al (a 0))
  (def bl (b 0))
  (var borrow 0)
  (for i 0 an
    (var bi borrow)
    (if (< i bn) (+= bi (bl i)))
    (def av (al i))
    (if (>= av bi)
      (do (set borrow 0) (put rl i (- av bi)))
      (do (set borrow 1) (put rl i (+ (- av bi) BASE)))))
  (put r 1 an)
  (put r 2 0)
  (big-trim r))

(defn big-add [r a b]
  (def an (a 2))
  (def bn (b 2))
  (if (= an bn)
    (do (add-mag r a b) (put r 2 an))
    (if (>= (cmp-mag a b) 0)
      (do (sub-mag r a b) (put r 2 an))
      (do (sub-mag r b a) (put r 2 bn))))
  (big-trim r))

(defn big-sub [r a b]
  (def an (a 2))
  (def bn (b 2))
  (if (not= an bn)
    (do (add-mag r a b) (put r 2 an))
    (if (>= (cmp-mag a b) 0)
      (do (sub-mag r a b) (put r 2 an))
      (do (sub-mag r b a) (put r 2 (if (= an 0) 1 0)))))
  (big-trim r))

(defn mul-small [r a m]
  (def rl (r 0))
  (def al (a 0))
  (def c (a 1))
  (if (or (= m 0) (= c 0))
    (do (put r 1 0) (put r 2 0))
    (do
      (var carry 0)
      (for i 0 c
        (def p (+ (* (al i) m) carry))
        (def cy (math/floor (/ p BASEF)))
        (def rem (- p (* cy BASEF)))
        (if (< i (length rl)) (put rl i rem) (array/push rl rem))
        (set carry cy))
      (var n c)
      (while (> carry 0)
        (def cy (math/floor (/ carry BASEF)))
        (def rem (- carry (* cy BASEF)))
        (if (< n (length rl)) (put rl n rem) (array/push rl rem))
        (set carry cy)
        (++ n))
      (put r 1 n)
      (put r 2 (a 2))
      (big-trim r))))

# floor(a / b) for a >= 0 and b > 0, by counting how many times b fits into a. The spigot
# only ever asks for a quotient of one decimal digit, so this terminates quickly.
(defn big-quot [a b w]
  (if (or (not= (a 2) 0) (not= (b 2) 0) (= (b 1) 0))
    0
    (do
      (big-copy w b)
      (var q 0)
      (while (>= (big-cmp a w) 0)
        (++ q)
        (add-mag w w b))
      q)))

(def q (big-new))
(def r (big-new))
(def t (big-new))
(def u (big-new))
(def v (big-new))
(def w (big-new))

(big-set q 1)
(big-set r 0)
(big-set t 1)

(var k 1)
(var l 3)
(var n 3)
(var sum 0)
(var produced 0)

(while (< produced 1000)
  (mul-small u q 4)
  (big-add u u r)                  # u = 4q + r
  (mul-small v t (+ n 1))          # v = (n + 1)t

  (if (< (big-cmp u v) 0)
    (do
      # the digit n is settled
      (+= sum n)
      (++ produced)

      (mul-small u q 3)
      (big-add u u r)
      (mul-small u u 10)           # u = 10(3q + r)
      (def nextn (- (big-quot u t w) (* 10 n)))

      (mul-small v t n)            # v = n t
      (big-sub v r v)              # v = r - n t
      (mul-small r v 10)           # r = 10(r - n t)
      (mul-small q q 10)           # q = 10q, t is unchanged

      (set n nextn))
    (do
      # not settled yet: widen the state by one more term
      (mul-small u q (+ (* 7 k) 2))
      (mul-small v r l)
      (big-add u u v)              # u = q(7k + 2) + r l
      (mul-small v t l)            # v = t l
      (def nextn (big-quot u v w))

      (mul-small u q 2)
      (big-add u u r)
      (mul-small u u l)            # u = (2q + r) l
      (big-copy r u)
      (mul-small q q k)
      (mul-small t t l)

      (++ k)
      (+= l 2)
      (set n nextn))))

(ss-report)
(print sum)
