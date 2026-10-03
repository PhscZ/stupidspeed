\ task 09 fib_recursive — expected output: 102334155
\ build: none (gforth interprets the file)
\ run:   gforth 09_fib_recursive.fs      (run from sources/gforth/)
\        gforth.exe is tools/gforth/gforth.exe; it finds its image gforth.fi beside the
\        executable, so the working directory only has to be sources/gforth/ so that
\        data.bin and out.bin resolve.
\ gforth 0.7.9. Forth is stack-based, so the accumulator lives on the data stack and each
\ loop body is a sequence of stack words. Loops are written with the standard BEGIN/UNTIL or
\ DO/LOOP forms.
\ Naive recursion, about 331 million calls. In Forth a recursive word has to RECURSE
\ because the definition is not visible under its own name while it is being compiled.
\ The stack comment must not contain a ')' of its own: Forth ends a ( ... ) comment at the
\ first ')', so a name like fib(n) inside the comment would end it early and leave the rest
\ to be read as code.

: fib  ( n -- fib )
  dup 2 < if exit then
  dup 1- recurse
  swap 2 - recurse
  +
;

: main
  40 fib . cr
;

main
bye
