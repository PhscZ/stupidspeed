{ task 10 pi — expected output: 44889 }
{ build: fpc -O3 -oprogram 10_pi.pas    run: ./program }
{ Windows x64: i386-win32 fpc + cross.x86_64-win64 add-on, build with -Px86_64; run as program.exe }
{ note: the RTL has no big integers, so Gibbons' unbounded spigot runs on hand-written
  sign-magnitude big integers: little-endian 64-bit limbs, base 1e9. Only what the spigot
  needs is here: add, subtract, multiply by a small int, and a quotient. The quotient is a
  single decimal digit, so it comes from a top-limb estimate plus a couple of compare-and-
  correct steps instead of a full long division. The digits are never printed, only their sum. }

program prog;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  BASE = 1000000000;   { 1e9, so limb * small + carry still fits in a 64-bit word }

type
  TBig = record
    neg: Boolean;
    d: array of UInt64;   { little-endian limbs, base 1e9, no leading zero limbs }
  end;

procedure Trim(var a: TBig);
var
  n: Integer;
begin
  n := Length(a.d);
  while (n > 0) and (a.d[n - 1] = 0) do
    Dec(n);
  if n <> Length(a.d) then
    SetLength(a.d, n);
  if n = 0 then
    a.neg := False;
end;

function CopyBig(const a: TBig): TBig;
begin
  Result.neg := a.neg;
  SetLength(Result.d, Length(a.d));
  if Length(a.d) > 0 then
    Move(a.d[0], Result.d[0], Length(a.d) * SizeOf(UInt64));
end;

function MagCmp(const a, b: TBig): Integer;
var
  i: Integer;
begin
  if Length(a.d) <> Length(b.d) then
  begin
    if Length(a.d) < Length(b.d) then
      Exit(-1)
    else
      Exit(1);
  end;
  for i := Length(a.d) - 1 downto 0 do
    if a.d[i] <> b.d[i] then
    begin
      if a.d[i] < b.d[i] then
        Exit(-1)
      else
        Exit(1);
    end;
  Result := 0;
end;

function BigCmp(const a, b: TBig): Integer;
begin
  if a.neg <> b.neg then
  begin
    if a.neg then
      Exit(-1)
    else
      Exit(1);
  end;
  Result := MagCmp(a, b);
  if a.neg then
    Result := -Result;
end;

function MagAdd(const a, b: TBig): TBig;
var
  i, n: Integer;
  s: UInt64;
begin
  if Length(a.d) >= Length(b.d) then
    n := Length(a.d)
  else
    n := Length(b.d);
  SetLength(Result.d, n);
  Result.neg := False;
  s := 0;
  for i := 0 to n - 1 do
  begin
    if i < Length(a.d) then
      s := s + a.d[i];
    if i < Length(b.d) then
      s := s + b.d[i];
    if s >= BASE then
    begin
      Result.d[i] := s - BASE;
      s := 1;
    end
    else
    begin
      Result.d[i] := s;
      s := 0;
    end;
  end;
  if s <> 0 then
  begin
    SetLength(Result.d, n + 1);
    Result.d[n] := 1;
  end;
end;

function MagSub(const a, b: TBig): TBig;   { requires |a| >= |b| }
var
  i, n: Integer;
  borrow: Int64;
  s: Int64;
begin
  n := Length(a.d);
  SetLength(Result.d, n);
  Result.neg := False;
  borrow := 0;
  for i := 0 to n - 1 do
  begin
    s := Int64(a.d[i]) - borrow;
    if i < Length(b.d) then
      s := s - Int64(b.d[i]);
    if s < 0 then
    begin
      s := s + Int64(BASE);
      borrow := 1;
    end
    else
      borrow := 0;
    Result.d[i] := UInt64(s);
  end;
  Trim(Result);
end;

function BigAdd(const a, b: TBig): TBig;
begin
  if a.neg = b.neg then
  begin
    Result := MagAdd(a, b);
    Result.neg := a.neg and (Length(Result.d) > 0);
  end
  else if MagCmp(a, b) >= 0 then
  begin
    Result := MagSub(a, b);
    Result.neg := a.neg and (Length(Result.d) > 0);
  end
  else
  begin
    Result := MagSub(b, a);
    Result.neg := b.neg and (Length(Result.d) > 0);
  end;
end;

function NegBig(const a: TBig): TBig;
begin
  Result := CopyBig(a);
  if Length(Result.d) > 0 then
    Result.neg := not Result.neg;
end;

function BigSub(const a, b: TBig): TBig;
begin
  Result := BigAdd(a, NegBig(b));
end;

function MulSmall(const a: TBig; m: Int64): TBig;
var
  i, n: Integer;
  cur, carry, mm: UInt64;
  negRes: Boolean;
begin
  n := Length(a.d);
  if (n = 0) or (m = 0) then
  begin
    SetLength(Result.d, 0);
    Result.neg := False;
    Exit;
  end;
  if m < 0 then
  begin
    negRes := not a.neg;
    mm := UInt64(-m);
  end
  else
  begin
    negRes := a.neg;
    mm := UInt64(m);
  end;
  SetLength(Result.d, n + 1);
  carry := 0;
  for i := 0 to n - 1 do
  begin
    cur := a.d[i] * mm + carry;
    Result.d[i] := cur mod BASE;
    carry := cur div BASE;
  end;
  if carry <> 0 then
    Result.d[n] := carry
  else
    SetLength(Result.d, n);
  Result.neg := negRes and (Length(Result.d) > 0);
end;

function BigFromInt(v: Int64): TBig;
begin
  if v = 0 then
  begin
    SetLength(Result.d, 0);
    Result.neg := False;
    Exit;
  end;
  Result.neg := v < 0;
  if v < 0 then
    v := -v;
  SetLength(Result.d, 1);
  Result.d[0] := UInt64(v);
end;

{ u div v for the magnitudes of u and v, v > 0, with rem set to u mod v. }
function MagQuot(const u, v: TBig; out rem: TBig): UInt64;
var
  nn, dn: Integer;
  q, lo, hi, step, mid: UInt64;
begin
  nn := Length(u.d);
  dn := Length(v.d);
  if (nn < dn) or ((nn = dn) and (MagCmp(u, v) < 0)) then
  begin
    rem := CopyBig(u);
    Exit(0);
  end;

  { start from the top limbs; for numbers this close together that is already within
    one of the answer, and the two loops below fix up the rest }
  if nn = dn then
  begin
    if dn = 1 then
      q := u.d[0] div v.d[0]
    else
      q := (u.d[nn - 1] * BASE + u.d[nn - 2]) div (v.d[dn - 1] * BASE + v.d[dn - 2]);
  end
  else if nn = dn + 1 then
    q := (u.d[nn - 1] * BASE + u.d[nn - 2]) div v.d[dn - 1]
  else
    q := 0;

  while (q > 0) and (MagCmp(MulSmall(v, Int64(q)), u) > 0) do
    Dec(q);
  step := 1;
  while MagCmp(MulSmall(v, Int64(q + step)), u) <= 0 do
  begin
    Inc(q, step);
    step := step * 2;
  end;
  lo := q;
  hi := q + step;
  while lo + 1 < hi do
  begin
    mid := lo + (hi - lo) div 2;
    if MagCmp(MulSmall(v, Int64(mid)), u) <= 0 then
      lo := mid
    else
      hi := mid;
  end;
  q := lo;
  rem := MagSub(u, MulSmall(v, Int64(q)));
  Result := q;
end;

{ floor(a / b), with b > 0. }
function BigDivFloor(const a, b: TBig): Int64;
var
  rem: TBig;
  q: UInt64;
begin
  if Length(a.d) = 0 then
    Exit(0);
  q := MagQuot(a, b, rem);
  if not a.neg then
    Result := Int64(q)
  else if Length(rem.d) = 0 then
    Result := -Int64(q)
  else
    Result := -Int64(q) - 1;
end;

var
  q, r, t, u, v: TBig;
  n, k, l, sum: Int64;
  produced: Integer;
begin
  q := BigFromInt(1);
  r := BigFromInt(0);
  t := BigFromInt(1);
  k := 1;
  n := 3;
  l := 3;
  sum := 0;
  produced := 0;

  while produced < 10000 do
  begin
    { 4q + r < (n + 1)t means the digit n is settled }
    u := BigAdd(MulSmall(q, 4), r);
    v := MulSmall(t, n + 1);
    if BigCmp(u, v) < 0 then
    begin
      Inc(sum, n);
      Inc(produced);
      { q, r, t, k, n, l := 10q, 10(r - n t), t, k, (10(3q + r)) div t - 10n, l }
      u := MulSmall(BigAdd(MulSmall(q, 3), r), 10);
      v := MulSmall(t, n);
      n := BigDivFloor(u, t) - 10 * n;
      r := MulSmall(BigSub(r, v), 10);
      q := MulSmall(q, 10);
    end
    else
    begin
      { q, r, t, k, n, l := q k, (2q + r) l, t l, k + 1,
                            (q(7k + 2) + r l) div (t l), l + 2 }
      u := BigAdd(MulSmall(q, 7 * k + 2), MulSmall(r, l));
      v := MulSmall(t, l);
      n := BigDivFloor(u, v);
      u := MulSmall(BigAdd(MulSmall(q, 2), r), l);
      r := u;
      q := MulSmall(q, k);
      t := v;
      Inc(k);
      Inc(l, 2);
    end;
  end;

  WriteLn(sum);
end.
