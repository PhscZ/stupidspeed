(* task 03 func_sum -- the add-one helper for 03_func_sum.mod *)
(* build: m2amd64.exe /sym:.;<adw>\ASCII\winamd64sym Func.def, then Func.mod; the caller links Func.obj *)
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
