// task 10 pi — expected output: 44889
// build: javac Main.java    run: java Main
// build (graalvm native-image): native-image -O2 Main    run: ./Main
// Gibbons' unbounded spigot on java.math.BigInteger; the leading 3 counts as one of the
// 10000 digits, and only the digit sum is printed.

import java.math.BigInteger;

public class Main {
    private static final BigInteger TWO = BigInteger.valueOf(2);
    private static final BigInteger THREE = BigInteger.valueOf(3);
    private static final BigInteger FOUR = BigInteger.valueOf(4);
    private static final BigInteger SEVEN = BigInteger.valueOf(7);
    private static final BigInteger TEN = BigInteger.TEN;

    public static void main(String[] args) {
        BigInteger q = BigInteger.ONE;
        BigInteger r = BigInteger.ZERO;
        BigInteger t = BigInteger.ONE;
        BigInteger k = BigInteger.ONE;
        BigInteger n = THREE;
        BigInteger l = THREE;

        long digitSum = 0;
        int digits = 0;
        while (digits < 10000) {
            if (q.multiply(FOUR).add(r).subtract(t).compareTo(n.multiply(t)) < 0) {
                digitSum += n.intValue();
                digits += 1;
                BigInteger qNext = q.multiply(TEN);
                BigInteger rNext = r.subtract(n.multiply(t)).multiply(TEN);
                n = q.multiply(THREE).add(r).multiply(TEN).divide(t).subtract(n.multiply(TEN));
                q = qNext;
                r = rNext;
                // t, k and l are unchanged on this branch
            } else {
                BigInteger qNext = q.multiply(k);
                BigInteger rNext = q.multiply(TWO).add(r).multiply(l);
                BigInteger tNext = t.multiply(l);
                n = q.multiply(k.multiply(SEVEN).add(TWO)).add(r.multiply(l)).divide(tNext);
                q = qNext;
                r = rNext;
                t = tNext;
                k = k.add(BigInteger.ONE);
                l = l.add(TWO);
            }
        }
        System.out.println(digitSum);
    }
}
