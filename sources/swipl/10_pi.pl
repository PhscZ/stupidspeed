% task 10 pi — expected output: 4470
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 10_pi.pl
% note: Gibbons' unbounded spigot, the same algorithm as the C row, but the big integers
%       are SWI-Prolog's own: integer arithmetic is unbounded (GMP) by default, so no
%       hand-rolled base-1e9 limbs are needed. The paired quotient/remainder of the
%       spigot is divmod/4, which SWI documents as almost twice as fast as doing the two
%       steps separately. At 1000 digits every operand is a few thousand bits, so the
%       whole spigot is a fast cell (milliseconds). Only the digit sum is printed.
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    spigot(1, 3, 3, 0, 0, 1, 0, 1, Sum),
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(standard_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Sum]).

% spigot(K, L, N, Produced, Sum, Q, R, T, Total)
spigot(_, _, _, Produced, Sum, _, _, _, Total) :-
    Produced >= 1000,
    !,
    Total = Sum.
spigot(K, L, N, Produced, Sum, Q, R, T, Total) :-
    U is 4 * Q + R,
    V is (N + 1) * T,
    (   U < V
    ->  % the digit N is settled
        Sum1 is Sum + N,
        Produced1 is Produced + 1,
        U2 is 10 * (3 * Q + R),
        divmod(U2, T, Qd, _),
        Next is Qd - 10 * N,
        V2 is R - N * T,
        R2 is 10 * V2,
        Q2 is 10 * Q,
        spigot(K, L, Next, Produced1, Sum1, Q2, R2, T, Total)
    ;   % not settled yet: widen the state by one more term
        U3 is Q * (7 * K + 2) + R * L,
        V3 is T * L,
        divmod(U3, V3, Next2, _),
        U4 is (2 * Q + R) * L,
        R4 = U4,
        Q4 is Q * K,
        T4 is T * L,
        K1 is K + 1,
        L1 is L + 2,
        spigot(K1, L1, Next2, Produced, Sum, Q4, R4, T4, Total)
    ).
