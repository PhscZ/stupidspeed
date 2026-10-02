! task 06 char_count — expected output: 10000000
! build: none (interpreted — the script is compiled and run on every invocation)
! run: tools/factor/factor.exe 06_char_count.factor    (from sources/factor/)
! note: the hundred-million-character string is built by replicating the whole ten-char
!       block and concatenating once, never by appending. Factor's `each` walks the string
!       as fixnum character codes.

USING: kernel locals math prettyprint sequences ;
IN: scratchpad

:: char-count ( -- count )
    10000000 [ "abcdefghij" ] replicate concat :> text
    0 text [| count ch |
        ch CHAR: a = [ count ]
        [ ch CHAR: e = [ count ]
          [ ch CHAR: h = [ count 1 + ] [ count ] if ] if ] if
    ] each ;

char-count .
