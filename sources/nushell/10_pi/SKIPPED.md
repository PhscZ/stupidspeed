# task 10 pi — SKIPPED

Nushell's only integer type is i64, and the standard library has no big-integer type, so
the unbounded spigot cannot get anywhere near 10000 digits of pi: a value with a few
hundred digits already overflows i64 (2 ** 200 is an overflow error, not a big number).
The benchmark therefore records this cell as SKIPPED.
