% task 11 parallel_sum — expected output: 7500000075000000
% build: none (interpreted)    run: swipl -q -O -f none -g main -t halt 11_parallel_sum.pl
% note: four real OS threads. library(thread)'s thread_create/3 creates a Prolog thread
%       backed by an operating-system thread (pthreads on Unix, pthread-win32 plus the
%       Windows native API on Windows) and each thread owns its own stacks, so the four
%       quarters really overlap; the parent blocks in thread_get_message/1, which is the
%       join. Each worker runs task 02's switch over its own fixed quarter
%       [t*25000000, (t+1)*25000000), so the answer cannot depend on finishing order.
% note: thread_create/3 copies the goal, so a worker cannot bind a parent variable. The
%       partials come back through the thread message queue: thread_send_message/2 in the
%       worker, thread_get_message/1 in the parent. thread_create(work(T,R), ...) would
%       silently leave R unbound.
% note: -O is required, see 01_branches.pl.

:- use_module(library(thread)).

main :-
    thread_self(Me),
    thread_create(work(Me, 0), Id0, []),
    thread_create(work(Me, 1), Id1, []),
    thread_create(work(Me, 2), Id2, []),
    thread_create(work(Me, 3), Id3, []),
    collect(4, 0, Total),
    thread_join(Id0, _),
    thread_join(Id1, _),
    thread_join(Id2, _),
    thread_join(Id3, _),
    format("~w~n", [Total]).

work(Me, T) :-
    Start is T * 25000000,
    End is (T + 1) * 25000000,
    wloop(Start, End, 0, R),
    thread_send_message(Me, result(T, R)).

wloop(I, End, Acc, R) :-
    (   I >= End
    ->  R = Acc
    ;   M is I mod 4,
        (   M =:= 0
        ->  Acc1 is Acc + 1
        ;   M =:= 1
        ->  Acc1 is Acc + I
        ;   M =:= 2
        ->  Acc1 is Acc + 2 * I
        ;   Acc1 is Acc + 3 * I
        ),
        I1 is I + 1,
        wloop(I1, End, Acc1, R)
    ).

collect(0, Acc, Total) :-
    !,
    Total = Acc.
collect(N, Acc0, Total) :-
    thread_get_message(result(_, R)),
    Acc1 is Acc0 + R,
    N1 is N - 1,
    collect(N1, Acc1, Total).
