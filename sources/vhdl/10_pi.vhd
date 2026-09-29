-- task 10 pi - expected output: 4470
-- build: ghdl -a --std=08 10_pi.vhd
-- run: ghdl -r --std=08 t10_pi
-- note: VHDL is a hardware description language, so a 'program' is a testbench entity and the
--       work happens inside the simulator. The measured number is therefore GHDL's mcode JIT
--       and event loop, not 'the language' -- the same disclosure the GDScript, Dolphin and
--       SystemVerilog rows carry.
-- note: --std=08 is required (numeric_std, std.env) and the mcode backend must be given the
--       same options at analysis and at run time, so both commands carry it.
-- note: the process ends with a bare 'wait;' rather than std.env.finish, because GHDL's finish
--       prints a "simulation finished @0ms" line to stdout and the task must print exactly one
--       line. The simulation ends when the event queue is empty, and that prints nothing.
-- note: VHDL has no bignum library, so this is the README's hand-rolled route: sign-magnitude,
--       little-endian, base-1e9 limbs with add, subtract, multiply by a small integer and a
--       quotient that comes out of repeated subtraction. The spigot is Gibbons' unbounded
--       spigot, the same loop as the C row's, and the digits themselves are never printed,
--       only their sum.
-- note: the limbs are 32-bit 'integer', not the C row's uint64_t. A base-1e9 limb is below
--       2^30, so every add, subtract and comparison stays inside the 31-bit signed range and
--       needs no wider type: a+b+carry is at most 1999999999.
-- note: the one place that does not fit is the scalar multiply: limb*m is up to 1e9 * 28002,
--       about 2^45, which no VHDL integer type holds. VHDL's only wider type is an unsigned
--       vector, whose numeric_std operators are ordinary VHDL bit loops under the mcode
--       backend -- microseconds each -- so multiplying by 2 (which does fit: 2*1e9 < 2^31) is
--       the primitive, and multiplying by m is a double-and-add over the bits of m, 15
--       doublings plus at most 15 additions. That is a real constant-factor cost over the C
--       row's single pass per limb, but it is all 32-bit integer arithmetic, which the mcode
--       JIT runs at about the same speed as the C row runs its uint64 limbs, so the cell still
--       comes out in seconds rather than minutes.
-- note: 1600 limbs of headroom; the state reaches 1250 limbs (about 11,250 decimal digits)
--       before the 1000th digit is emitted, measured on the C row's instrumented twin, and the
--       same twin counts 151077867 limb operations for the 1000-digit run. Verified against
--       that twin at 10, 100, 300 and 1000 digits (39, 471, 1337, 4470).
library ieee;
use std.textio.all;

entity t10_pi is
end entity;

architecture sim of t10_pi is
  constant BASE    : integer := 1000000000;
  constant MAXLIMB : integer := 1600;
  constant NDIG    : integer := 1000;

  type limbs_t is array (0 to MAXLIMB - 1) of integer;

  type big_t is record
    limb : limbs_t;
    len  : integer;
    neg  : boolean;
  end record;

  constant BIG_ZERO : big_t := (limb => (others => 0), len => 0, neg => false);

  function big_set (v : integer) return big_t is
    variable r : big_t := BIG_ZERO;
    variable t : integer := v;
  begin
    while t > 0 loop
      r.limb(r.len) := t mod BASE;
      r.len := r.len + 1;
      t := t / BASE;
    end loop;
    return r;
  end function;

  function big_trim (x : big_t) return big_t is
    variable r : big_t := x;
  begin
    while r.len > 0 and r.limb(r.len - 1) = 0 loop
      r.len := r.len - 1;
    end loop;
    if r.len = 0 then
      r.neg := false;
    end if;
    return r;
  end function;

  function big_cmp_mag (a, b : big_t) return integer is
  begin
    if a.len /= b.len then
      if a.len < b.len then
        return -1;
      else
        return 1;
      end if;
    end if;
    for i in a.len - 1 downto 0 loop
      if a.limb(i) /= b.limb(i) then
        if a.limb(i) < b.limb(i) then
          return -1;
        else
          return 1;
        end if;
      end if;
    end loop;
    return 0;
  end function;

  function big_cmp (a, b : big_t) return integer is
  begin
    if a.neg /= b.neg then
      if a.neg then
        return -1;
      else
        return 1;
      end if;
    end if;
    if a.neg then
      return -big_cmp_mag(a, b);
    else
      return big_cmp_mag(a, b);
    end if;
  end function;

  function big_add_mag (a, b : big_t) return big_t is
    variable r : big_t := BIG_ZERO;
    variable n : integer;
    variable s : integer;
    variable c : integer := 0;
  begin
    if a.len > b.len then
      n := a.len;
    else
      n := b.len;
    end if;
    for i in 0 to n - 1 loop
      s := a.limb(i) + b.limb(i) + c;
      if s >= BASE then
        s := s - BASE;
        c := 1;
      else
        c := 0;
      end if;
      r.limb(i) := s;
    end loop;
    r.len := n;
    if c = 1 then
      r.limb(n) := 1;
      r.len := n + 1;
    end if;
    return r;
  end function;

  function big_sub_mag (a, b : big_t) return big_t is
    variable r : big_t := BIG_ZERO;
    variable bi : integer;
    variable borrow : integer := 0;
  begin
    for i in 0 to a.len - 1 loop
      bi := b.limb(i) + borrow;
      if a.limb(i) >= bi then
        r.limb(i) := a.limb(i) - bi;
        borrow := 0;
      else
        r.limb(i) := a.limb(i) + BASE - bi;
        borrow := 1;
      end if;
    end loop;
    r.len := a.len;
    return big_trim(r);
  end function;

  function big_add (a, b : big_t) return big_t is
    variable r : big_t;
  begin
    if a.neg = b.neg then
      r := big_add_mag(a, b);
      r.neg := a.neg;
    elsif big_cmp_mag(a, b) >= 0 then
      r := big_sub_mag(a, b);
      r.neg := a.neg;
    else
      r := big_sub_mag(b, a);
      r.neg := b.neg;
    end if;
    return big_trim(r);
  end function;

  function big_sub (a, b : big_t) return big_t is
    variable nb : big_t := b;
  begin
    nb.neg := not b.neg;
    return big_add(a, nb);
  end function;

  procedure big_dbl (variable x : inout big_t) is
    variable p : integer;
    variable c : integer := 0;
  begin
    for i in 0 to x.len - 1 loop
      p := x.limb(i) * 2 + c;
      if p >= BASE then
        x.limb(i) := p - BASE;
        c := 1;
      else
        x.limb(i) := p;
        c := 0;
      end if;
    end loop;
    if c = 1 then
      x.limb(x.len) := 1;
      x.len := x.len + 1;
    end if;
  end procedure;

  function big_mul_small (a : big_t; m : integer) return big_t is
    variable r   : big_t := BIG_ZERO;
    variable tmp : big_t := a;
    variable b   : integer := m;
  begin
    if m = 0 or a.len = 0 then
      return BIG_ZERO;
    end if;
    while b > 0 loop
      if b mod 2 = 1 then
        r := big_add_mag(r, tmp);
      end if;
      b := b / 2;
      if b > 0 then
        big_dbl(tmp);
      end if;
    end loop;
    r.neg := a.neg;
    return big_trim(r);
  end function;

  function big_quot (a, b : big_t) return integer is
    variable q : integer := 0;
    variable w : big_t := b;
  begin
    if a.neg or b.neg or b.len = 0 then
      return 0;
    end if;
    while big_cmp(a, w) >= 0 loop
      q := q + 1;
      w := big_add_mag(w, b);
    end loop;
    return q;
  end function;
begin
  process
    variable q, r, t : big_t;
    variable u, v    : big_t;
    variable k, l, n : integer;
    variable nxt     : integer;
    variable sum     : integer := 0;
    variable produced : integer := 0;
    variable lln     : line;
  begin
    q := big_set(1);
    r := big_set(0);
    t := big_set(1);

    k := 1;
    l := 3;
    n := 3;

    while produced < NDIG loop
      u := big_mul_small(q, 4);
      u := big_add(u, r);
      v := big_mul_small(t, n + 1);

      if big_cmp(u, v) < 0 then
        sum := sum + n;
        produced := produced + 1;

        u := big_mul_small(q, 3);
        u := big_add(u, r);
        u := big_mul_small(u, 10);
        nxt := big_quot(u, t) - 10 * n;

        v := big_mul_small(t, n);
        v := big_sub(r, v);
        r := big_mul_small(v, 10);
        q := big_mul_small(q, 10);
        n := nxt;
      else
        u := big_mul_small(q, 7 * k + 2);
        v := big_mul_small(r, l);
        u := big_add(u, v);
        v := big_mul_small(t, l);
        nxt := big_quot(u, v);

        u := big_mul_small(q, 2);
        u := big_add(u, r);
        u := big_mul_small(u, l);
        r := u;

        q := big_mul_small(q, k);
        t := big_mul_small(t, l);

        k := k + 1;
        l := l + 2;
        n := nxt;
      end if;
    end loop;

    write(lln, sum);
    writeline(output, lln);
    wait;
  end process;
end architecture;
