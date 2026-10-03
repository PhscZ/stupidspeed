% task 14 file_read — expected output: 2389704704
% build: mmc --make m14_file_read -o prog    run: ./prog
% note: data.bin must be in the working directory.

:- module m14_file_read.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module int, list, string.

main(!IO) :-
    io.open_binary_input("data.bin", OpenRes, !IO),
    (
        OpenRes = ok(Stream),
        read_all(Stream, 0, Total, !IO),
        io.close_binary_input(Stream, !IO),
        io.format("%d\n", [i(Total mod 4294967296)], !IO)
    ;
        OpenRes = error(Error),
        io.format("cannot open data.bin: %s\n",
            [s(io.error_message(Error))], !IO),
        io.set_exit_status(1, !IO)
    ).

:- pred read_all(io.binary_input_stream::in, int::in, int::out,
    io::di, io::uo) is det.
read_all(Stream, !Total, !IO) :-
    io.read_byte(Stream, Result, !IO),
    ( if Result = ok(Byte) then
        !:Total = !.Total + Byte,
        read_all(Stream, !Total, !IO)
    else if Result = error(Error) then
        io.format("read error: %s\n", [s(io.error_message(Error))], !IO),
        io.set_exit_status(1, !IO)
    else
        true
    ).
