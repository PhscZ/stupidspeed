(* task 03 func_sum -- the add-one helper for 03_func_sum.mod *)
(* build: m2amd64.exe /sym:<symdir> Func.mod, before compiling 03_func_sum.mod, then link *)
(*        Func.obj alongside Task03.obj (see the build line in 03_func_sum.mod). *)
(*        Func.def is the matching definition module. *)
(* note: this is a separate module so the 100000000 calls cannot be inlined away: Modula-2 *)
(*       compiles each module on its own and the caller only ever sees the declaration in *)
(*       Func.def, never this body. *)
IMPLEMENTATION MODULE Func;

PROCEDURE AddOne (n : LONGCARD) : LONGCARD;
BEGIN
   RETURN n + 1
END AddOne;

END Func.
