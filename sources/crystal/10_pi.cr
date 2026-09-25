# task 10 pi — expected output: 44889
# build: crystal build --release -o prog 10_pi.cr    run: ./prog
# note: Gibbons' unbounded spigot on the stdlib BigInt; only the sum of the first
# 10000 emitted digits is printed, never the digits. Same algorithm as ruby/python rows.

require "big"

DIGITS = 10000

q = 1.to_big_i
r = 0.to_big_i
t = 1.to_big_i
k = 1.to_big_i
n = 3.to_big_i
l = 3.to_big_i

total = 0.to_big_i
emitted = 0

while emitted < DIGITS
  if 4 * q + r - t < n * t
    total += n
    emitted += 1
    q, r, t, k, n, l = 10 * q, 10 * (r - n * t), t, k, (10 * (3 * q + r)) // t - 10 * n, l
  else
    q, r, t, k, n, l = q * k, (2 * q + r) * l, t * l, k + 1, (q * (7 * k + 2) + r * l) // (t * l), l + 2
  end
end

puts total
