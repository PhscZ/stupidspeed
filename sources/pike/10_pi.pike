// task 10 pi — expected output: 9092
// build: none (interpreted)    run: pike 10_pi.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// Pike's int is 64-bit, so the Gibbons spigot runs on the arbitrary-precision integers in
// the standard library: Gmp.mpz, whose / is a real integer division.  Only the sum of the
// 2000 digits is printed.

int main() {
    int __t0 = gethrtime(1);
    Gmp.mpz q = Gmp.mpz(1), r = Gmp.mpz(0), t = Gmp.mpz(1);
    Gmp.mpz k = Gmp.mpz(1), n = Gmp.mpz(3), l = Gmp.mpz(3);
    Gmp.mpz sum = Gmp.mpz(0);
    int produced = 0;

    while (produced < 2000) {
        if (4 * q + r - t < n * t) {
            sum = sum + n;
            produced = produced + 1;
            Gmp.mpz nx = (10 * (3 * q + r)) / t - 10 * n;
            r = 10 * (r - n * t);
            q = 10 * q;
            n = nx;
        } else {
            Gmp.mpz nx = (q * (7 * k + 2) + r * l) / (t * l);
            r = (2 * q + r) * l;
            q = q * k;
            t = t * l;
            n = nx;
            k = k + 1;
            l = l + 2;
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", (int) sum);
    return 0;
}
