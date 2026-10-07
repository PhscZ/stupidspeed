% task 08 average — expected output: 0.498046875
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 08_average.pl
% note: / is float division when an operand is a float; 256.0 forces it. Every term is a
%       dyadic multiple of 1/256 and the running total stays far below 2^44, so the sum is
%       exact and the final average is exactly 0.498046875. write/1 prints a float with
%       the minimal digits that read back to the same value, so the line is as expected
%       (SWI's digit grouping only appears with ~D / ~:d, which this row never uses).
% note: -O is required, see 01_branches.pl.

main :-
    get_time(T0),
    loop(0, 0.0, Total),
    Avg is Total / 100000000,
    get_time(T1),
    Ms is (T1 - T0) * 1000,
    format(user_error, "TIME_MS=~3f~n", [Ms]),
    format("~w~n", [Avg]).

loop(I, Acc, Total) :-
    (   I >= 100000000
    ->  Total = Acc
    ;   Reading is (I mod 256) / 256.0,
        Acc1 is Acc + Reading,
        I1 is I + 1,
        loop(I1, Acc1, Total)
    ).
