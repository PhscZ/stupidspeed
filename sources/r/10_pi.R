# task 10 pi — expected output: 44889
# build: Rscript 10_pi.R    run: Rscript 10_pi.R
#
# Unbounded spigot (Gibbons), emitting the leading 3 first, summing the first
# 10000 digits it emits. R has no arbitrary-precision integers, so the state
# (q, r, t) is carried as sign/magnitude vectors of base-10^9 limbs, with the
# multiply-by-a-small-integer, the add, the subtract and the compare written
# by hand. Every intermediate stays below 2^53, so doubles hold limbs exactly.
# Both divisions in the spigot have a quotient below 100, so the big/big
# division is a normalised two-limb estimate plus a correction step or two.

BASE <- 1e9
NDIGITS <- 10000

# --- base-10^9 limbs, little-endian, no leading zero limbs -------------------

mk <- function(m, s) {
  n <- length(m)
  while (n > 1 && m[n] == 0) n <- n - 1
  if (n == 1 && m[1] == 0) return(list(s = 1, m = 0))
  if (n < length(m)) m <- m[seq_len(n)]
  list(s = s, m = m)
}

ZERO <- list(s = 1, m = 0)
ONE <- list(s = 1, m = 1)

cmp_mag <- function(a, b) {
  if (length(a) != length(b)) return(if (length(a) > length(b)) 1 else -1)
  d <- which(a != b)
  if (length(d) == 0) return(0)
  i <- d[length(d)]
  if (a[i] > b[i]) 1 else -1
}

cmp <- function(x, y) {
  if (x$s != y$s) return(if (x$s > y$s) 1 else -1)
  x$s * cmp_mag(x$m, y$m)
}

add_mag <- function(a, b) {
  la <- length(a)
  lb <- length(b)
  n <- if (la > lb) la else lb
  s <- numeric(n)
  s[seq_len(la)] <- a
  s[seq_len(lb)] <- s[seq_len(lb)] + b
  s <- c(s, 0)
  repeat {
    o <- s >= BASE
    if (!any(o)) break
    o <- as.numeric(o)
    s <- s - o * BASE
    s <- s + c(0, o[seq_len(length(s) - 1)])
  }
  n <- length(s)
  while (n > 1 && s[n] == 0) n <- n - 1
  if (n < length(s)) s <- s[seq_len(n)]
  s
}

sub_mag <- function(a, b) {          # requires a >= b
  s <- a
  lb <- length(b)
  s[seq_len(lb)] <- s[seq_len(lb)] - b
  repeat {
    o <- s < 0
    if (!any(o)) break
    o <- as.numeric(o)
    s <- s + o * BASE
    s <- s - c(0, o[seq_len(length(s) - 1)])
  }
  n <- length(s)
  while (n > 1 && s[n] == 0) n <- n - 1
  if (n < length(s)) s <- s[seq_len(n)]
  s
}

add <- function(x, y) {
  if (x$s == y$s) return(mk(add_mag(x$m, y$m), x$s))
  k <- cmp_mag(x$m, y$m)
  if (k == 0) return(ZERO)
  if (k > 0) mk(sub_mag(x$m, y$m), x$s) else mk(sub_mag(y$m, x$m), y$s)
}

sub <- function(x, y) {
  if (length(y$m) == 1 && y$m[1] == 0) return(x)
  add(x, list(s = -y$s, m = y$m))
}

mul_small <- function(x, m) {
  if (m == 0) return(ZERO)
  p <- x$m * m
  lo <- p %% BASE
  hi <- (p - lo) / BASE
  s <- c(lo, 0) + c(0, hi)
  repeat {
    o <- s >= BASE
    if (!any(o)) break
    o <- as.numeric(o)
    s <- s - o * BASE
    s <- s + c(0, o[seq_len(length(s) - 1)])
  }
  mk(s, x$s)
}

# floor(A / B) for magnitudes. The spigot's quotients are below 100 and the
# estimate from the two leading limbs is accurate to within one, so the
# correction loops take a step or two; they are exact for any quotient.
div_quot <- function(A, B) {
  if (cmp_mag(A, B) < 0) return(0)
  la <- length(A)
  lb <- length(B)
  a0 <- if (la >= 2) A[la - 1] else 0
  b0 <- if (lb >= 2) B[lb - 1] else 0
  est <- ((A[la] + a0 / BASE) / (B[lb] + b0 / BASE)) * BASE^(la - lb)
  q <- if (is.finite(est) && est > 0) floor(est) else 0
  if (q > 4096) q <- 4096
  P <- mul_small(list(s = 1, m = B), q)$m
  while (cmp_mag(P, A) > 0) {
    q <- q - 1
    P <- sub_mag(P, B)
  }
  repeat {
    Q <- add_mag(P, B)
    if (cmp_mag(Q, A) > 0) break
    P <- Q
    q <- q + 1
  }
  q
}

# --- the spigot --------------------------------------------------------------

pi_digit_sum <- function() {
  q <- ONE
  r <- ZERO
  t <- ONE
  k <- 1
  n <- 3
  l <- 3
  count <- 0
  total <- 0
  while (count < NDIGITS) {
    if (cmp(sub(add(mul_small(q, 4), r), t), mul_small(t, n)) < 0) {
      total <- total + n
      count <- count + 1
      nxt <- div_quot(mul_small(add(mul_small(q, 3), r), 10)$m, t$m) - 10 * n
      newr <- mul_small(sub(r, mul_small(t, n)), 10)
      q <- mul_small(q, 10)
      r <- newr
      n <- nxt
    } else {
      nxt <- div_quot(add(mul_small(q, 7 * k + 2), mul_small(r, l))$m,
                      mul_small(t, l)$m)
      newr <- mul_small(add(mul_small(q, 2), r), l)
      newt <- mul_small(t, l)
      q <- mul_small(q, k)
      r <- newr
      t <- newt
      k <- k + 1
      n <- nxt
      l <- l + 2
    }
  }
  cat(sprintf("%.0f\n", total))
}

pi_digit_sum()
