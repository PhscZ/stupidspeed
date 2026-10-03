NB. task 07 string_append — expected output: 250000
NB. build: none (interpreted)    run: jconsole.exe 07_string_append.ijs
NB. note: text =: text , 'x' is the plain append loop the task asks for, and it is
NB.       what this file measures. J documents that x , y may append to x in place
NB.       when x is a zombie (the same name on both sides, no other reference), so
NB.       this cell is expected to be linear rather than the quadratic copy the task
NB.       is designed to probe — the same situation the Raku, Erlang and Elixir rows
NB.       record. It is measured and recorded, not worked around.
NB. note: while., not for_i. i. 250000, for the reason in 01_branches.ijs.

string_append =: 3 : 0
  text =. ''
  i =. 0
  while. i < 250000 do.
    text =. text , 'x'
    i =. i + 1
  end.
  ": # text
)

stdout (string_append''), LF
exit 0
