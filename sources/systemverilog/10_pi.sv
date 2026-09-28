// task 10 pi — expected output: 4470
// build: iverilog -g2012 -o prog.vvp 10_pi.sv
// run: vvp prog.vvp
// note: SystemVerilog is a hardware description language, so a 'program' is a testbench
//       module with an initial block and the work is done by the simulator. The measured
//       number is therefore Icarus Verilog's code generator and event loop, not 'the
//       language' -- the same disclosure the GDScript, Dolphin and VHDL rows carry.
// note: -g2012 is required. Plain Verilog has no automatic functions, and without them a
//       recursive function shares one static frame and silently returns wrong answers
//       (fib(10) comes out as -80 instead of 55), so this row is SystemVerilog and not
//       Verilog. That is also why no Verilog row exists.
// note: SystemVerilog has no arbitrary-precision integer, so this is the same hand-written big
//       integer the C row uses: sign-magnitude, little-endian base-1e9 limbs, with add,
//       subtract, multiply by a small integer, and a quotient that is always one decimal digit
//       and so comes out of repeated subtraction. Same Gibbons unbounded spigot, same update
//       order. The spigot never produces a negative value, so the limbs are unsigned and the
//       sign handling of the C version is dropped.
// note: limbs are longint (64-bit signed). A limb times a small multiplier is at most
//       999999999 * 232472 ~= 2.3e14, far inside 2^63, so every product and carry is exact.
// note: the six big integers live in one two-dimensional array indexed by a constant, rather
//       than being passed around as arrays, because that is what keeps the operations cheap in
//       a simulator. The state reaches about 3200 limbs at 1000 digits, so each is sized 8000.
// note: this is the slowest cell in the row: about 720 million limb operations at roughly 5 us
//       each puts the full run at around an hour, which the benchmark's no-timeout rule allows.
//       It was verified at 100, 200, 400 and 1000 digits against independently computed digit
//       sums before the full run.

module tb;
  localparam int LIMBS = 8000;
  localparam longint BASE = 1000000000;

  // indices into L and N
  localparam int Q = 0, R = 1, T = 2, U = 3, V = 4, W = 5;

  longint L [0:5][0:LIMBS-1];
  int N [0:5];
  bit neg [0:5];

  // --- trim: drop leading zero limbs
  function automatic void trim(input int x);
    while (N[x] > 0 && L[x][N[x]-1] == 0) N[x] = N[x] - 1;
    if (N[x] == 0) neg[x] = 0;
  endfunction

  // --- set from a small value
  function automatic void big_set(input int x, input longint v);
    N[x] = 0;
    neg[x] = 0;
    while (v > 0) begin
      L[x][N[x]] = v % BASE;
      N[x] = N[x] + 1;
      v = v / BASE;
    end
  endfunction

  function automatic void big_copy(input int dst, input int src);
    for (int i = 0; i < N[src]; i++) L[dst][i] = L[src][i];
    N[dst] = N[src];
    neg[dst] = neg[src];
  endfunction

  function automatic int cmp_mag(input int a, input int b);
    if (N[a] != N[b]) return (N[a] < N[b]) ? -1 : 1;
    for (int i = N[a] - 1; i >= 0; i--) begin
      if (L[a][i] != L[b][i]) return (L[a][i] < L[b][i]) ? -1 : 1;
    end
    return 0;
  endfunction

  function automatic void add_mag(input int r, input int a, input int b);
    int len;
    longint carry, s;
    len = (N[a] > N[b]) ? N[a] : N[b];
    carry = 0;
    for (int i = 0; i < len; i++) begin
      s = carry;
      if (i < N[a]) s = s + L[a][i];
      if (i < N[b]) s = s + L[b][i];
      if (s >= BASE) begin L[r][i] = s - BASE; carry = 1; end
      else begin L[r][i] = s; carry = 0; end
    end
    if (carry != 0) begin L[r][len] = carry; len = len + 1; end
    N[r] = len;
    trim(r);
  endfunction

  // requires |a| >= |b|
  function automatic void sub_mag(input int r, input int a, input int b);
    longint borrow, bi;
    int an, bn;
    an = N[a]; bn = N[b];
    borrow = 0;
    for (int i = 0; i < an; i++) begin
      bi = borrow;
      if (i < bn) bi = bi + L[b][i];
      if (L[a][i] >= bi) begin L[r][i] = L[a][i] - bi; borrow = 0; end
      else begin L[r][i] = L[a][i] + BASE - bi; borrow = 1; end
    end
    N[r] = an;
    trim(r);
  endfunction

  // signed compare, the C row's big_cmp
  function automatic int cmp_signed(input int a, input int b);
    if (neg[a] != neg[b]) return neg[a] ? -1 : 1;
    begin
      int c;
      c = cmp_mag(a, b);
      return neg[a] ? -c : c;
    end
  endfunction

  function automatic void big_add(input int r, input int a, input int b);
    if (neg[a] == neg[b]) begin
      add_mag(r, a, b);
      neg[r] = neg[a] && (N[r] > 0);
    end
    else if (cmp_mag(a, b) >= 0) begin
      sub_mag(r, a, b);
      neg[r] = neg[a] && (N[r] > 0);
    end
    else begin
      sub_mag(r, b, a);
      neg[r] = neg[b] && (N[r] > 0);
    end
  endfunction

  // r = a - b, signed. This is the operation the spigot needs: r - n*t goes negative early on,
  // and an unsigned implementation wraps to a huge value and never terminates.
  function automatic void big_sub(input int r, input int a, input int b);
    if (neg[a] != neg[b]) begin
      add_mag(r, a, b);
      neg[r] = neg[a] && (N[r] > 0);
    end
    else if (cmp_mag(a, b) >= 0) begin
      sub_mag(r, a, b);
      neg[r] = neg[a] && (N[r] > 0);
    end
    else begin
      sub_mag(r, b, a);
      neg[r] = (!neg[a]) && (N[r] > 0);
    end
  endfunction

  function automatic void mul_small(input int r, input int a, input longint m);
    longint carry, p;
    int len;
    if (m == 0 || N[a] == 0) begin N[r] = 0; neg[r] = 0; return; end
    carry = 0;
    for (int i = 0; i < N[a]; i++) begin
      p = L[a][i] * m + carry;
      L[r][i] = p % BASE;
      carry = p / BASE;
    end
    len = N[a];
    while (carry > 0) begin
      L[r][len] = carry % BASE;
      len = len + 1;
      carry = carry / BASE;
    end
    N[r] = len;
    neg[r] = neg[a];
    trim(r);
  endfunction

  // floor(a / b), a >= 0, b > 0. The spigot only ever asks for a quotient below 128, so a
  // binary search over 0..127 finds it in seven comparisons. The C row does this by repeated
  // subtraction, which is what a compiled language can afford; in a simulator each subtraction
  // is O(limbs) and there can be a hundred of them per call, so repeated subtraction is the
  // single most expensive thing in this row -- measured at over 30 minutes for the 100-digit
  // case before this was changed. work must not alias a or b.
  function automatic longint big_quot(input int a, input int b, input int work);
    longint lo, hi, mid;
    if (neg[a] || neg[b] || N[b] == 0) return 0;
    lo = 0; hi = 127;
    while (lo < hi) begin
      mid = (lo + hi + 1) / 2;
      mul_small(work, b, mid);
      if (cmp_mag(work, a) <= 0) lo = mid;
      else hi = mid - 1;
    end
    return lo;
  endfunction

  longint sum, next, k, l, n;
  int produced;

  initial begin
    big_set(Q, 1);
    big_set(R, 0);
    big_set(T, 1);

    k = 1; l = 3; n = 3;
    sum = 0; produced = 0;

    while (produced < 1000) begin
      mul_small(U, Q, 4);
      big_add(U, U, R);                 // u = 4q + r
      mul_small(V, T, n + 1);           // v = (n + 1)t

      if (cmp_signed(U, V) < 0) begin
        // the digit n is settled
        sum = sum + n;
        produced = produced + 1;

        mul_small(U, Q, 3);
        big_add(U, U, R);
        mul_small(U, U, 10);                    // u = 10(3q + r)
        next = big_quot(U, T, W) - 10 * n;

        mul_small(V, T, n);                     // v = n t
        big_sub(V, R, V);                       // v = r - n t
        mul_small(R, V, 10);                    // r = 10(r - n t)
        mul_small(Q, Q, 10);                    // q = 10q, t unchanged

        n = next;
      end
      else begin
        // not settled: widen the state by one more term
        mul_small(U, Q, 7 * k + 2);
        mul_small(V, R, l);
        big_add(U, U, V);                       // u = q(7k + 2) + r l
        mul_small(V, T, l);                     // v = t l
        next = big_quot(U, V, W);

        mul_small(U, Q, 2);
        big_add(U, U, R);
        mul_small(U, U, l);                     // u = (2q + r) l
        big_copy(R, U);
        mul_small(Q, Q, k);
        mul_small(T, T, l);

        k = k + 1;
        l = l + 2;
        n = next;
      end
    end

    $display("%0d", sum);
    $finish(0);
  end
endmodule
