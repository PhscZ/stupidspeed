% task 10 pi — expected output: 9092
% build: gplc --no-top-level -o 10_pi.exe 10_pi.pl <shim.c>
% run:   exec/gprolog/gplc/10_pi/10_pi.exe
%
% note: GNU Prolog integers are 60-bit (PL_MAX_INTEGER = 1152921504606846975), so there
%       is no bignum type and no GMP: the arbitrary-precision state is hand-written, as
%       the README's task 10 requires of a language without a bignum library. The
%       algorithm is Gibbons' unbounded spigot, the same loop as sources/c/10_pi.c, and
%       only the digit sum is printed.
% note: a big integer is b(Sign, Limbs): sign in {-1, 0, 1} and Limbs a little-endian
%       base-1e9 limb list with no leading zero limbs -- sign-magnitude little-endian
%       limbs, the same representation the C row hand-writes. The four operations the
%       spigot needs are add, subtract, multiply by a small integer, and a quotient.
%       Every multiplier is bounded by 7k+2 or l, which reach about 50000 over the run,
%       so limb * multiplier + carry stays below 5.1e13 and 60-bit arithmetic is enough;
%       no wide arithmetic is needed.
% note: the quotient is found by binary search on the multiplier -- double the bound
%       until bound*b > a, then bisect -- rather than by the C row's repeated
%       subtraction. The spigot's quotients are at most about 110 (it asks for one
%       decimal digit at a time, plus the 10x of the settled-digit step; measured over
%       the whole run: 99), so the search is about seven multiplications of a big number
%       by a small one, against up to 99 whole-number subtractions for the same answer.
%       Both give floor(a/b); the search is simply the cheaper way to get it in this
%       runtime, where every limb touched costs heap. The search is safe for this
%       program because the bound reaches 128 at most, so limb * bound stays below
%       1.3e11 and 60-bit arithmetic cannot overflow; a quotient near 1e9 would.
% note: the loop is failure-driven -- repeat/0, one spigot step, then cut or fail -- with
%       the state in a global variable, and NOT the tail recursion the swipl row uses.
%       That is forced, and the manual says why twice over:
%         * GNU Prolog 1.5.0 has no garbage collector. The manual never mentions one,
%           garbage_collect/0 does not exist at run time
%           ("existence_error(procedure,garbage_collect/0)"), and the global stack
%           pointer only ever moves forward. A tail-recursive spigot over these limbs
%           needs about 4 GB of heap for the ~4.8e8 limb reads it makes (measured: it
%           overflows a 1.5 GB heap), because arg/3 leaves 8 bytes behind per call and
%           nothing reclaims it.
%         * The manual's note on repeat/0 is the fix: "when the test fails back, the
%           Prolog engine immediately reclaims any working storage consumed since the
%           call to repeat/0". So each step's temporaries are reclaimed.
%       The state therefore lives in a global variable, which is also forced: a
%       backtracking loop resets the heap, so a term stored with setarg/3 into a
%       pre-existing compound is clobbered by the reset (measured: arg/3 on it raises
%       instantiation_error). g_assign/2 is documented as storing a *copy* and as not
%       being undone at backtracking, so the state survives. The algorithm, the order of
%       the spigot's steps and the answer are the tail-recursive form's.
% note: measured region: the spigot only. The native pipeline (pl2wam, wam2ma, ma2asm,
%       as, gcc) is at build time; see 01_branches.pl.

:- initialization(main).

main :-
    real_time(T0),
    g_assign(spigot_state, st(1, 3, 3, 0, 0, b(1, [1]), b(0, []), b(1, [1]))),
    spigot,
    g_read(spigot_state, st(_, _, _, _, Sum, _, _, _)),
    real_time(T1),
    Ms is T1 - T0,
    format(user_error, "TIME_MS=~w~n", [Ms]),
    format("~w~n", [Sum]),
    halt.

spigot :-
    repeat,
    step,
    g_read(spigot_state, st(_, _, _, Produced, _, _, _, _)),
    (   Produced >= 2000
    ->  !
    ;   fail
    ).

% One spigot step: read the state, compute the next one, write it back.
step :-
    g_read(spigot_state, st(K, L, N, Produced, Sum, Q, R, T)),
    b_mul(Q, 4, Q4),
    b_add(Q4, R, U),                 % u = 4q + r
    N1 is N + 1,
    b_mul(T, N1, V),                 % v = (n + 1)t
    (   b_lt(U, V)                   % 4q + r < (n + 1)t, i.e. 4q + r - t < n t
    ->  % the digit n is settled
        Sum1 is Sum + N,
        Produced1 is Produced + 1,
        b_mul(Q, 3, Q3),
        b_add(Q3, R, W1),
        b_mul(W1, 10, W2),           % u = 10(3q + r)
        b_quot(W2, T, Qd),
        Next is Qd - 10 * N,
        b_mul(T, N, V2),             % v = n t
        b_sub(R, V2, V3),            % v = r - n t
        b_mul(V3, 10, R1),           % r = 10(r - n t)
        b_mul(Q, 10, Q1),            % q = 10q, t is unchanged
        g_assign(spigot_state, st(K, L, Next, Produced1, Sum1, Q1, R1, T))
    ;   % not settled yet: widen the state by one more term
        K7 is 7 * K + 2,
        b_mul(Q, K7, U1),
        b_mul(R, L, U3),
        b_add(U1, U3, U4),           % u = q(7k + 2) + r l
        b_mul(T, L, V4),             % v = t l
        b_quot(U4, V4, Next2),
        b_mul(Q, 2, Q5),
        b_add(Q5, R, W3),
        b_mul(W3, L, R4),            % r = (2q + r) l
        b_mul(Q, K, Q6),             % q = q k
        b_mul(T, L, T4),             % t = t l
        K1 is K + 1,
        L1 is L + 2,
        g_assign(spigot_state, st(K1, L1, Next2, Produced, Sum, Q6, R4, T4))
    ).

% ---------------------------------------------------------------- big integers
% b(Sign, Limbs): Sign in {-1, 0, 1} and zero iff Sign is 0; Limbs little-endian base
% 1e9 with no leading zero limb. b(0, []) is the only representation of zero.

% Drop leading zero limbs (the most significant limb is the LAST element of the list, so
% the zero limbs to drop are at the tail). Every producer of a magnitude routes through
% here, which is what keeps b_cmp_mag's length comparison meaningful.
b_norm(S, L, R) :-
    b_strip(L, L1),
    (   L1 == []
    ->  R = b(0, [])
    ;   R = b(S, L1)
    ).

b_strip([], []) :-
    !.
b_strip([X], R) :-
    !,
    (   X =:= 0
    ->  R = []
    ;   R = [X]
    ).
b_strip([X | T], R) :-
    b_strip(T, R1),
    (   R1 == [],
        X =:= 0
    ->  R = []
    ;   R = [X | R1]
    ).

% magnitude comparison, one pass, most significant limb last
b_cmp_mag([], [], 0) :-
    !.
b_cmp_mag([], [_ | _], -1) :-
    !.
b_cmp_mag([_ | _], [], 1) :-
    !.
b_cmp_mag([X | T1], [Y | T2], C) :-
    b_cmp_mag(T1, T2, C1),
    (   C1 =\= 0
    ->  C = C1
    ;   X < Y
    ->  C = -1
    ;   X > Y
    ->  C = 1
    ;   C = 0
    ).

b_cmp(b(S1, L1), b(S2, L2), C) :-
    (   S1 =:= S2
    ->  b_cmp_mag(L1, L2, C0),
        (   S1 < 0
        ->  C is -C0
        ;   C = C0
        )
    ;   S1 < S2
    ->  C = -1
    ;   C = 1
    ).

b_lt(A, B) :-
    b_cmp(A, B, C),
    C < 0.

b_add(b(S1, L1), b(S2, L2), R) :-
    (   S1 =:= 0
    ->  R = b(S2, L2)
    ;   S2 =:= 0
    ->  R = b(S1, L1)
    ;   S1 =:= S2
    ->  b_add_mag(L1, L2, L),
        b_norm(S1, L, R)
    ;   b_cmp_mag(L1, L2, C),
        (   C >= 0
        ->  b_sub_mag(L1, L2, L),
            S = S1
        ;   b_sub_mag(L2, L1, L),
            S = S2
        ),
        b_norm(S, L, R)
    ).

b_sub(b(S1, L1), b(S2, L2), R) :-
    S2n is -S2,
    b_add(b(S1, L1), b(S2n, L2), R).

b_add_mag(A, B, R) :-
    b_addc(A, B, 0, R).

b_addc([], [], 0, []) :-
    !.
b_addc([], [], C, [C]) :-
    !.
b_addc([X | T], B, C, R) :-
    b_head(B, Y, Bt),
    S is X + Y + C,
    (   S >= 1000000000
    ->  S1 is S - 1000000000,
        C1 = 1
    ;   S1 = S,
        C1 = 0
    ),
    b_addc(T, Bt, C1, R1),
    R = [S1 | R1].
b_addc([], [Y | Bt], C, R) :-         % A ran out first; B still has limbs
    S is Y + C,
    (   S >= 1000000000
    ->  S1 is S - 1000000000,
        C1 = 1
    ;   S1 = S,
        C1 = 0
    ),
    b_addc([], Bt, C1, R1),
    R = [S1 | R1].

b_head([], 0, []) :-
    !.
b_head([Y | T], Y, T).

% |A| - |B| as an unnormalized limb list; the callers normalize.
b_sub_mag(A, B, R) :-
    b_subc(A, B, 0, R).

b_subc([], [], 0, []) :-
    !.
b_subc([X | T], B, Bor, R) :-
    b_head(B, Y, Bt),
    S is X - Y - Bor,
    (   S < 0
    ->  S1 is S + 1000000000,
        Bor1 = 1
    ;   S1 = S,
        Bor1 = 0
    ),
    b_subc(T, Bt, Bor1, R1),
    R = [S1 | R1].

b_mul(_, 0, R) :-
    !,
    R = b(0, []).
b_mul(b(_, []), _, R) :-
    !,
    R = b(0, []).
b_mul(b(S, L), M, R) :-
    b_mulc(L, M, 0, R0),
    b_norm(S, R0, R).

b_mulc([], _, C, R) :-
    b_carry(C, R).
b_mulc([X | T], M, C, R) :-
    P is X * M + C,
    Q is P mod 1000000000,
    C1 is P // 1000000000,
    b_mulc(T, M, C1, R1),
    R = [Q | R1].

b_carry(0, []) :-
    !.
b_carry(C, R) :-
    Q is C mod 1000000000,
    C1 is C // 1000000000,
    b_carry(C1, R1),
    R = [Q | R1].

% floor(A / B) for A >= 0 and B > 0: double the bound until bound*B > A, then bisect.
b_quot(b(S, _), _, 0) :-
    S =< 0,
    !.
b_quot(_, b(S, _), 0) :-
    S =< 0,
    !.
b_quot(A, B, Q) :-
    b_bs_up(A, B, 1, Hi),
    b_bs(A, B, 0, Hi, Q).

b_bs_up(A, B, Hi0, Hi) :-
    b_mul(B, Hi0, P),
    (   b_cmp_mag_p(P, A, C),
        C > 0
    ->  Hi = Hi0
    ;   Hi1 is Hi0 * 2,
        b_bs_up(A, B, Hi1, Hi)
    ).

b_bs(A, B, Lo, Hi, Q) :-
    (   Lo >= Hi
    ->  Q = Lo
    ;   Mid is (Lo + Hi + 1) // 2,
        b_mul(B, Mid, P),
        (   b_cmp_mag_p(P, A, C),
            C =< 0
        ->  b_bs(A, B, Mid, Hi, Q)
        ;   Mid1 is Mid - 1,
            b_bs(A, B, Lo, Mid1, Q)
        )
    ).

b_cmp_mag_p(b(_, L1), b(_, L2), C) :-
    b_cmp_mag(L1, L2, C).
