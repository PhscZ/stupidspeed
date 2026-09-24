-- task 10 pi — expected output: 44889
-- build: gnatmake -O3 main.adb    run: ./main
-- Ada's standard library has no big integers, so Gibbons' unbounded spigot is
-- run on hand-written big integers: little-endian sign-magnitude limbs in
-- Interfaces.Unsigned_64, base 10**9.  Only a multiply by a small integer, an
-- add, a subtract, a compare and a division whose quotient is small are
-- needed.  The spigot emits pi's digits one at a time; the sum of the first
-- 10000 of them, the leading 3 included, is printed instead of the digits.
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Integer_IO;
with Interfaces; use type Interfaces.Unsigned_64;

procedure Main is
   package LL_IO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);

   Digits : constant := 10_000;                     --  digits emitted and summed
   Base   : constant Interfaces.Unsigned_64 := 1_000_000_000;

   --  The state grows to about 145000 decimal digits -- roughly 16200 limbs --
   --  by the time the 10000th digit comes out, so this leaves room to spare.
   Max_Limbs : constant := 65_536;

   type Limb_Array is array (1 .. Max_Limbs) of Interfaces.Unsigned_64;

   type Big is record
      Neg : Boolean := False;                 --  sign, ignored when Len = 0
      Len : Natural := 0;                     --  limbs in use
      D   : Limb_Array := (others => 0);      --  little endian, base 10**9
   end record;

   type Big_Ptr is access Big;

   procedure Set_Small (X : Big_Ptr; V : Interfaces.Unsigned_64) is
      --  X := V, for a small V
   begin
      X.Neg := False;
      if V = 0 then
         X.Len := 0;
      else
         X.Len := 1;
         X.D (1) := V;
      end if;
   end Set_Small;

   procedure Copy (Dst : Big_Ptr; Src : Big_Ptr) is
   begin
      Dst.Neg := Src.Neg;
      Dst.Len := Src.Len;
      for I in 1 .. Src.Len loop
         Dst.D (I) := Src.D (I);
      end loop;
   end Copy;

   function Mag_Cmp (A : Big_Ptr; B : Big_Ptr) return Integer is
      --  compares the magnitudes |A| and |B|
   begin
      if A.Len /= B.Len then
         if A.Len > B.Len then
            return 1;
         else
            return -1;
         end if;
      end if;
      for I in reverse 1 .. A.Len loop
         if A.D (I) /= B.D (I) then
            if A.D (I) > B.D (I) then
               return 1;
            else
               return -1;
            end if;
         end if;
      end loop;
      return 0;
   end Mag_Cmp;

   function Cmp (A : Big_Ptr; B : Big_Ptr) return Integer is
      --  signed comparison, -1, 0 or 1
      A_Neg : constant Boolean := A.Neg and then A.Len > 0;
      B_Neg : constant Boolean := B.Neg and then B.Len > 0;
      C     : Integer;
   begin
      if A_Neg /= B_Neg then
         if A_Neg then
            return -1;
         else
            return 1;
         end if;
      end if;
      C := Mag_Cmp (A, B);
      if A_Neg then
         return -C;
      else
         return C;
      end if;
   end Cmp;

   procedure Mag_Add (R : Big_Ptr; A : Big_Ptr; B : Big_Ptr) is
      --  R := |A| + |B|.  R must not be A or B.
      Carry : Interfaces.Unsigned_64 := 0;
      S     : Interfaces.Unsigned_64;
      N     : Natural;
   begin
      N := Natural'Max (A.Len, B.Len);
      for I in 1 .. N loop
         S := Carry;
         if I <= A.Len then
            S := S + A.D (I);
         end if;
         if I <= B.Len then
            S := S + B.D (I);
         end if;
         R.D (I) := S mod Base;
         Carry := S / Base;
      end loop;
      if Carry > 0 then
         N := N + 1;
         R.D (N) := Carry;
      end if;
      R.Len := N;
   end Mag_Add;

   procedure Mag_Sub (R : Big_Ptr; A : Big_Ptr; B : Big_Ptr) is
      --  R := |A| - |B|, which needs |A| >= |B|.  R must not be A or B.
      Borrow : Interfaces.Unsigned_64 := 0;
      S      : Interfaces.Unsigned_64;
      T      : Interfaces.Unsigned_64;
   begin
      for I in 1 .. A.Len loop
         S := A.D (I);
         if I <= B.Len then
            T := B.D (I) + Borrow;
         else
            T := Borrow;
         end if;
         if S >= T then
            S := S - T;
            Borrow := 0;
         else
            S := S + Base - T;
            Borrow := 1;
         end if;
         R.D (I) := S;
      end loop;
      R.Len := A.Len;
      while R.Len > 0 and then R.D (R.Len) = 0 loop
         R.Len := R.Len - 1;
      end loop;
   end Mag_Sub;

   procedure Add_Sub
     (R : Big_Ptr; A : Big_Ptr; B : Big_Ptr; Invert_B : Boolean)
   is
      --  R := A + B, or R := A - B when Invert_B.  R must not be A or B.
      B_Neg : Boolean := B.Neg;
   begin
      if Invert_B then
         B_Neg := not B.Neg;
      end if;

      if A.Neg = B_Neg then
         Mag_Add (R, A, B);
         R.Neg := A.Neg;
      elsif Mag_Cmp (A, B) >= 0 then
         Mag_Sub (R, A, B);
         R.Neg := A.Neg;
      else
         Mag_Sub (R, B, A);
         R.Neg := B_Neg;
      end if;

      if R.Len = 0 then
         R.Neg := False;
      end if;
   end Add_Sub;

   procedure Mul_Small (R : Big_Ptr; A : Big_Ptr; M : Interfaces.Unsigned_64) is
      --  R := A * M for a small M.  R may be A.
      Carry : Interfaces.Unsigned_64 := 0;
      Prod  : Interfaces.Unsigned_64;
      N     : Natural;
   begin
      if M = 0 or else A.Len = 0 then
         R.Neg := False;
         R.Len := 0;
         return;
      end if;

      for I in 1 .. A.Len loop
         Prod := A.D (I) * M + Carry;
         R.D (I) := Prod mod Base;
         Carry := Prod / Base;
      end loop;

      N := A.Len;
      while Carry > 0 loop
         N := N + 1;
         R.D (N) := Carry mod Base;
         Carry := Carry / Base;
      end loop;

      R.Len := N;
      R.Neg := A.Neg;
   end Mul_Small;

   function Div_Quot
     (A : Big_Ptr; B : Big_Ptr; W : Big_Ptr) return Interfaces.Unsigned_64
   is
      --  floor(A / B) for A >= 0 and B > 0, found by binary search because
      --  every quotient the spigot asks for is small.  In the emission branch
      --  10*(3*q + r)/t is 10*n plus the next digit, so at most 99; in the
      --  other branch (q*(7*k + 2) + r*l)/(t*l) is the next digit, at most 9.
      --  W is scratch space and must not be A or B.
      Lo  : Interfaces.Unsigned_64 := 0;
      Hi  : Interfaces.Unsigned_64 := 127;
      Mid : Interfaces.Unsigned_64;
   begin
      if A.Len < B.Len then
         return 0;                            --  A < B
      end if;

      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         Mul_Small (W, B, Mid);
         if Cmp (W, A) <= 0 then
            Lo := Mid;
         else
            Hi := Mid - 1;
         end if;
      end loop;

      return Lo;
   end Div_Quot;

   Q  : constant Big_Ptr := new Big;          --  q
   R  : constant Big_Ptr := new Big;          --  r
   T  : constant Big_Ptr := new Big;          --  t
   A1 : constant Big_Ptr := new Big;          --  scratch
   A2 : constant Big_Ptr := new Big;          --  scratch
   A3 : constant Big_Ptr := new Big;          --  scratch
   A4 : constant Big_Ptr := new Big;          --  scratch
   A5 : constant Big_Ptr := new Big;          --  scratch
   A6 : constant Big_Ptr := new Big;          --  scratch
   Work : constant Big_Ptr := new Big;        --  scratch for Div_Quot

   K       : Integer := 1;                    --  k, stays small
   N       : Integer := 3;                    --  n, a digit
   L       : Integer := 3;                    --  l, stays small
   Emitted : Natural := 0;
   Total   : Long_Long_Integer := 0;
   Quot    : Interfaces.Unsigned_64;
begin
   Set_Small (Q, 1);
   Set_Small (R, 0);
   Set_Small (T, 1);

   while Emitted < Digits loop
      --  if 4*q + r - t < n*t then emit n else advance the state
      Mul_Small (A1, Q, 4);                              --  4*q
      Add_Sub (A2, A1, R, False);                        --  4*q + r
      Add_Sub (A1, A2, T, True);                         --  4*q + r - t
      Mul_Small (A2, T, Interfaces.Unsigned_64 (N));     --  n*t

      if Cmp (A1, A2) < 0 then
         Total := Total + Long_Long_Integer (N);
         Emitted := Emitted + 1;

         --  q := 10*q ; r := 10*(r - n*t) ; t unchanged ;
         --  n := floor(10*(3*q + r)/t) - 10*n ; k, l unchanged.
         Mul_Small (A1, T, Interfaces.Unsigned_64 (N));  --  n*t
         Add_Sub (A2, R, A1, True);                      --  r - n*t
         Mul_Small (A3, Q, 3);                           --  3*q
         Add_Sub (A4, A3, R, False);                     --  3*q + r
         Mul_Small (A1, A4, 10);                         --  10*(3*q + r)
         Quot := Div_Quot (A1, T, Work);
         Mul_Small (A2, A2, 10);                         --  10*(r - n*t)
         Copy (R, A2);
         Mul_Small (Q, Q, 10);                           --  10*q
         N := Integer (Quot) - 10 * N;
      else
         --  q := q*k ; r := (2*q + r)*l ; t := t*l ; k := k+1 ;
         --  n := floor((q*(7*k + 2) + r*l)/(t*l)) ; l := l+2.
         Mul_Small (A1, Q, Interfaces.Unsigned_64 (K));           --  q*k
         Mul_Small (A2, Q, 2);                                    --  2*q
         Add_Sub (A3, A2, R, False);                              --  2*q + r
         Mul_Small (A2, A3, Interfaces.Unsigned_64 (L));          --  (2*q + r)*l
         Mul_Small (A3, T, Interfaces.Unsigned_64 (L));           --  t*l
         Mul_Small (A4, Q, Interfaces.Unsigned_64 (7 * K + 2));   --  q*(7*k+2)
         Mul_Small (A5, R, Interfaces.Unsigned_64 (L));           --  r*l
         Add_Sub (A6, A4, A5, False);                             --  numerator
         Quot := Div_Quot (A6, A3, Work);
         Copy (Q, A1);
         Copy (R, A2);
         Copy (T, A3);
         N := Integer (Quot);
         K := K + 1;
         L := L + 2;
      end if;
   end loop;

   LL_IO.Put (Item => Total, Width => 1);
   New_Line;
end Main;
