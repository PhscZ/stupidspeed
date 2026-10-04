# task 09 fib_recursive — expected output: 102334155
# build: none (interpreted)    run: octave-cli -qf 09_fib_recursive.m
#
# Naive recursion, no memoisation: about 331 million calls for fib(40).
# note: the call is `fib(40)` itself, so there is no loop here at all.
# note: the function is defined above the call, in this same file. Octave allows
# a script to carry its own function definitions, but only defines them when the
# definition itself is executed, so a definition placed after the call is still
# undefined when the call runs. The leading 1; keeps the first token of the file
# from being `function`, which is what makes the file a script with local
# functions rather than a function file.
# note: Octave walks the parse tree on every call and has no inliner, so this is
# a real recursive call each time. It is the slowest cell in the row: measured at
# 1432.9 s for the full fib(40) (331160281 calls, 4.33 us each), and separately
# at fib(30)/34/36/38 against independently computed Fibonacci values, which come
# out at 6.22/5.32/4.79/4.35 us per call -- linear in the call count, as a
# tree-walking interpreter should be. See temp/octave-doc.md and RUN.md.

1;
__t0 = tic;

function r = fib(n)
  if n < 2
    r = n;
  else
    r = fib(n - 1) + fib(n - 2);
  end
end

fprintf(stderr, "TIME_MS=%.3f\n", toc(__t0) * 1000);
printf("%.0f\n", fib(40));
