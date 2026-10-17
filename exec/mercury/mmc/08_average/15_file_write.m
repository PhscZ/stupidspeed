% task 15 file_write — expected output: 419430400
% build: mmc --make m15_file_write -o prog    run: ./prog
% note: 8 passes of 50 chunks of 1 MiB, each chunk holding bytes 0..255 repeated 4096
%       times; every pass reopens out.bin from offset 0.
% timing: time.clock is Mercury's CPU clock, in ticks, with time.clocks_per_sec
%         ticks per second (1000 on Windows), so TIME_MS is whole milliseconds of
%         CPU time; io.stderr_stream is the standard error stream, so stdout is
%         unchanged. Verified on this machine with
%         mercury_compile --make <module> --grade hlc.gc.pregen.

:- module m15_file_write.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string, time.

main(!IO) :-
    time.clock(SS_T0, !IO),
    write_passes(0, 8, 0, Written, !IO),
    time.clock(SS_T1, !IO),
    SS_MS = (SS_T1 - SS_T0) * 1000 / time.clocks_per_sec,
    io.format(io.stderr_stream, "TIME_MS=%d\n", [i(SS_MS)], !IO),
    io.format("%d\n", [i(Written)], !IO).

:- pred write_passes(int::in, int::in, int::in, int::out, io::di, io::uo) is det.
write_passes(I, N, Acc, Total, !IO) :-
    ( if I >= N then
        Total = Acc
    else
        io.open_binary_output("out.bin", OpenRes, !IO),
        (
            OpenRes = ok(Stream),
            write_chunks(0, 50, Stream, 0, Pass, !IO),
            io.close_binary_output(Stream, !IO),
            write_passes(I + 1, N, Acc + Pass, Total, !IO)
        ;
            OpenRes = error(Error),
            io.format("cannot open out.bin: %s\n",
                [s(io.error_message(Error))], !IO),
            io.set_exit_status(1, !IO),
            Total = Acc
        )
    ).

:- pred write_chunks(int::in, int::in, io.binary_output_stream::in,
    int::in, int::out, io::di, io::uo) is det.
write_chunks(I, N, Stream, !Written, !IO) :-
    ( if I >= N then
        true
    else
        write_chunk(0, 1048576, Stream, !Written, !IO),
        write_chunks(I + 1, N, Stream, !Written, !IO)
    ).

:- pred write_chunk(int::in, int::in, io.binary_output_stream::in,
    int::in, int::out, io::di, io::uo) is det.
write_chunk(J, M, Stream, !Written, !IO) :-
    ( if J >= M then
        true
    else
        io.write_byte(Stream, J mod 256, !IO),
        !:Written = !.Written + 1,
        write_chunk(J + 1, M, Stream, !Written, !IO)
    ).
