(* task 10 pi — expected output: 44889 *)
(* build: ocamlopt -unsafe -o prog.exe _10_pi.ml *)
(* run: prog.exe *)
(* note: the row is built from the MSYS2 UCRT64 package mingw-w64-ucrt-x86_64-ocaml
         (OCaml 5.4.1). Two environment details are required and are not obvious:
         OCAMLLIB must be set to the *Windows* form of the stdlib directory
         (C:\...\ucrt64\lib\ocaml), because ocamlopt is a native Win32 binary and the
         MSYS2-style /ucrt64/... path baked into its config resolves to nothing -- without
         it every compile fails with 'Unbound module Stdlib'. And the separate
         mingw-w64-ucrt-x86_64-flexdll package has to be installed, or the link step stops
         with "'flexlink' is not recognized". *)
(* note: -unsafe turns off array and string bounds checks, which is the usual speed knob
         for OCaml. -O3 is accepted but is a no-op here: this switch reports
         flambda: false, and -O3 only does anything under Flambda. *)
(* note: filenames carry the row's _ prefix. OCaml derives a module name from the file
         name and a module name has to be a valid identifier, so 01_branches.ml draws
         'Warning 24: bad source file name'; _01_branches.ml compiles clean. *)
(* note: OCaml has no arbitrary-precision integers built in -- a native int is 63 bits and
         there is nothing wider in the standard library -- so this is the same hand-written big
         integer the C row uses, ported operation for operation: sign-magnitude, little-endian
         base-1e9 limbs in int64 arrays, with add, subtract, multiply by a small integer, and a
         quotient that is always one decimal digit and so comes out of repeated subtraction.
         Same Gibbons unbounded spigot, same update order.
   note: limbs are int64. A limb times a small multiplier is at most 999999999 * 232472 ~= 2.3e18,
         which fits a signed 64-bit integer (max 9.2e18), so the products and carries are exact.
         The package zarith would give real bignums but is not in MSYS2's UCRT64 repository, so
         the limbs are hand-rolled, exactly as the GDScript and ActionScript rows do. *)

let base = 1_000_000_000L
let limbs = 20000

type big = { limb : int64 array; mutable n : int; mutable neg : bool }

let make_big () = { limb = Array.make limbs 0L; n = 0; neg = false }

let trim x =
  while x.n > 0 && x.limb.(x.n - 1) = 0L do x.n <- x.n - 1 done;
  if x.n = 0 then x.neg <- false

let set_big x v =
  x.n <- 0; x.neg <- false;
  let v = ref v in
  while !v > 0L do
    x.limb.(x.n) <- Int64.rem !v base;
    x.n <- x.n + 1;
    v := Int64.div !v base
  done

let copy_big dst src =
  if dst != src then begin
    Array.blit src.limb 0 dst.limb 0 src.n;
    dst.n <- src.n;
    dst.neg <- src.neg
  end

let cmp_mag a b =
  if a.n <> b.n then compare a.n b.n
  else begin
    let r = ref 0 in
    let i = ref (a.n - 1) in
    while !r = 0 && !i >= 0 do
      if a.limb.(!i) <> b.limb.(!i) then r := compare a.limb.(!i) b.limb.(!i);
      decr i
    done;
    !r
  end

let cmp a b =
  if a.neg <> b.neg then (if a.neg then -1 else 1)
  else let c = cmp_mag a b in if a.neg then -c else c

let add_mag r a b =
  let len = max a.n b.n in
  let carry = ref 0L in
  for i = 0 to len - 1 do
    let s = ref !carry in
    if i < a.n then s := Int64.add !s a.limb.(i);
    if i < b.n then s := Int64.add !s b.limb.(i);
    if Int64.compare !s base >= 0 then begin r.limb.(i) <- Int64.sub !s base; carry := 1L end
    else begin r.limb.(i) <- !s; carry := 0L end
  done;
  let n = ref len in
  if !carry <> 0L then begin r.limb.(len) <- !carry; n := len + 1 end;
  r.n <- !n;
  trim r

let sub_mag r a b =
  let an = a.n and bn = b.n in
  let borrow = ref 0L in
  for i = 0 to an - 1 do
    let bi = ref !borrow in
    if i < bn then bi := Int64.add !bi b.limb.(i);
    if Int64.compare a.limb.(i) !bi >= 0 then begin r.limb.(i) <- Int64.sub a.limb.(i) !bi; borrow := 0L end
    else begin r.limb.(i) <- Int64.add (Int64.sub a.limb.(i) !bi) base; borrow := 1L end
  done;
  r.n <- an;
  trim r

let add r a b =
  if a.neg = b.neg then begin add_mag r a b; r.neg <- a.neg && r.n > 0 end
  else if cmp_mag a b >= 0 then begin sub_mag r a b; r.neg <- a.neg && r.n > 0 end
  else begin sub_mag r b a; r.neg <- b.neg && r.n > 0 end

let sub r a b =
  if a.neg <> b.neg then begin add_mag r a b; r.neg <- a.neg && r.n > 0 end
  else if cmp_mag a b >= 0 then begin sub_mag r a b; r.neg <- a.neg && r.n > 0 end
  else begin sub_mag r b a; r.neg <- (not a.neg) && r.n > 0 end

let mul_small r a m =
  if m = 0L || a.n = 0 then begin r.n <- 0; r.neg <- false end
  else begin
    let carry = ref 0L in
    for i = 0 to a.n - 1 do
      let p = Int64.add (Int64.mul a.limb.(i) m) !carry in
      r.limb.(i) <- Int64.rem p base;
      carry := Int64.div p base
    done;
    let len = ref a.n in
    while !carry > 0L do
      r.limb.(!len) <- Int64.rem !carry base;
      incr len;
      carry := Int64.div !carry base
    done;
    r.n <- !len;
    r.neg <- a.neg;
    trim r
  end

(* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one decimal
   digit, so counting how many times b fits into a is enough -- the same repeated subtraction the
   C row does. work must not alias a or b. *)
let quot a b work =
  if a.neg || b.neg || b.n = 0 then 0L
  else begin
    let q = ref 0L in
    copy_big work b;
    while cmp a work >= 0 do
      q := Int64.add !q 1L;
      add_mag work work b
    done;
    !q
  end

let () =
  let q = make_big () and r = make_big () and t = make_big () in
  let u = make_big () and v = make_big () and w = make_big () in

  set_big q 1L; set_big r 0L; set_big t 1L;

  let k = ref 1L and l = ref 3L and n = ref 3L in
  let sum = ref 0L and produced = ref 0 in

  while !produced < 10000 do
    mul_small u q 4L;
    add u u r;                            (* u = 4q + r *)
    mul_small v t (Int64.add !n 1L);      (* v = (n + 1)t *)

    if cmp u v < 0 then begin
      (* the digit n is settled *)
      sum := Int64.add !sum !n;
      incr produced;

      mul_small u q 3L;
      add u u r;
      mul_small u u 10L;                          (* u = 10(3q + r) *)
      let next = Int64.sub (quot u t w) (Int64.mul 10L !n) in

      mul_small v t !n;                           (* v = n t *)
      sub v r v;                                  (* v = r - n t *)
      mul_small r v 10L;                          (* r = 10(r - n t) *)
      mul_small q q 10L;                          (* q = 10q, t is unchanged *)

      n := next
    end else begin
      (* not settled yet: widen the state by one more term *)
      mul_small u q (Int64.add (Int64.mul 7L !k) 2L);
      mul_small v r !l;
      add u u v;                                  (* u = q(7k + 2) + r l *)
      mul_small v t !l;                           (* v = t l *)
      let next = quot u v w in

      mul_small u q 2L;
      add u u r;
      mul_small u u !l;                           (* u = (2q + r) l *)
      copy_big r u;
      mul_small q q !k;
      mul_small t t !l;

      k := Int64.add !k 1L;
      l := Int64.add !l 2L;
      n := next
    end
  done;

  Printf.printf "%Ld\n" !sum
