// task 10 pi — expected output: 44889
// build: none (interpreted)    run: groovy 10_pi.groovy
// java.math.BigInteger is arbitrary precision, so this is the real Gibbons unbounded
// spigot with no hand-rolled limbs: the GDScript/BASIC/Pascal/COBOL rows only need
// those because their languages have no big integers. Only the digit sum is printed.

def (q, r, t, k, n, l) = [1G, 0G, 1G, 1G, 3G, 3G]
long total = 0
long emitted = 0

while (emitted < 10000L) {
    if (4G * q + r - t < n * t) {
        total += n.longValue()
        emitted += 1
        def q2 = 10G * q
        def r2 = 10G * (r - n * t)
        def n2 = (10G * (3G * q + r)).divide(t) - 10G * n
        q = q2
        r = r2
        n = n2
    } else {
        def q2 = q * k
        def r2 = (2G * q + r) * l
        def t2 = t * l
        def n2 = (q * (7G * k + 2G) + r * l).divide(t2)
        q = q2
        r = r2
        t = t2
        k = k + 1G
        n = n2
        l = l + 2G
    }
}

println total
