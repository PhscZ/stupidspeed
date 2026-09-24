// task 10 pi — expected output: 44889
// build: go build -o prog main.go    run: ./prog
// note: plain "go build" only; do not set GOGC=off or any other tuning flags
package main

import (
	"fmt"
	"math/big"
)

// Gibbons' unbounded spigot, on math/big integers. The state is
// (q, r, t, k, n, l) and the two rules below are exactly the ones from the paper.
func main() {
	q := big.NewInt(1)
	r := big.NewInt(0)
	t := big.NewInt(1)
	k := big.NewInt(1)
	n := big.NewInt(3)
	l := big.NewInt(3)

	one := big.NewInt(1)
	two := big.NewInt(2)
	seven := big.NewInt(7)
	ten := big.NewInt(10)

	const digits = 10000
	sum := 0
	emitted := 0
	for emitted < digits {
		// if 4*q + r - t < n*t then emit n
		lhs := new(big.Int).Lsh(q, 2)
		lhs.Add(lhs, r)
		lhs.Sub(lhs, t)
		rhs := new(big.Int).Mul(n, t)

		if lhs.Cmp(rhs) < 0 {
			sum += int(n.Int64())
			emitted++
			// q, r, t, k, n, l = 10*q, 10*(r-n*t), t, k, (10*(3*q+r))/t - 10*n, l
			nq := new(big.Int).Mul(q, ten)
			nr := new(big.Int).Sub(r, new(big.Int).Mul(n, t))
			nr.Mul(nr, ten)
			nn := new(big.Int).Lsh(q, 1)
			nn.Add(nn, q)
			nn.Add(nn, r)
			nn.Mul(nn, ten)
			nn.Div(nn, t)
			nn.Sub(nn, new(big.Int).Mul(n, ten))
			q, r, n = nq, nr, nn
		} else {
			// q, r, t, k, n, l = q*k, (2*q+r)*l, t*l, k+1, (q*(7*k+2)+r*l)/(t*l), l+2
			nq := new(big.Int).Mul(q, k)
			nr := new(big.Int).Lsh(q, 1)
			nr.Add(nr, r)
			nr.Mul(nr, l)
			nt := new(big.Int).Mul(t, l)
			num := new(big.Int).Mul(k, seven)
			num.Add(num, two)
			num.Mul(num, q)
			num.Add(num, new(big.Int).Mul(r, l))
			nn := new(big.Int).Div(num, nt)
			nk := new(big.Int).Add(k, one)
			nl := new(big.Int).Add(l, two)
			q, r, t, k, n, l = nq, nr, nt, nk, nn, nl
		}
	}
	fmt.Println(sum)
}
