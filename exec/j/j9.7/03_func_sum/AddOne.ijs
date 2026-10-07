NB. AddOne.ijs — the task 03 helper, in its own file.
NB. J has no separate compilation and no inlining of user verbs, so there is no
NB. no-inline marker to apply: every call to add_one is an interpreted call into
NB. this definition's namespace. Splitting it into a second file is therefore not
NB. what keeps the call alive — the interpreter does that on its own — but it is
NB. the shape the task asks for and the one the other interpreted rows use.

add_one =: 3 : 0
  y + 1
)
