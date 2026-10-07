NB. task 06 char_count — expected output: 10000000
NB. build: none (interpreted)    run: jconsole.exe 06_char_count.ijs
NB. note: the 100 MB text is built once, by reshaping the ten-character block
NB.       (100000000 atoms = the block repeated 10000000 times), never by appending
NB.       in a loop. J's literal precision is one byte per atom, so this is exactly
NB.       the 100-million-character text the task describes.
NB. note: the scan is a per-character while. loop over the text with i { text, not a
NB.       bulk count of 'h' with +/ text = 'h'. The 'a' and 'e' branches are the
NB.       empty else-if arms the task asks for, present as comments in their bodies.
NB. note: while., not for_i. i. 100000000, for the reason in 01_branches.ijs.

t0 =: 6!:1 ''

char_count =: 3 : 0
  text =. 100000000 $ 'abcdefghij'
  n =. # text
  count =. 0
  i =. 0
  while. i < n do.
    ch =. i { text
    if. ch = 'a' do.
      NB. skip
    elseif. ch = 'e' do.
      NB. skip
    elseif. ch = 'h' do.
      count =. count + 1
    end.
    i =. i + 1
  end.
  ": count
)

res =: char_count''
t1 =: 6!:1 ''
stderr 'TIME_MS=', (": (t1 - t0) * 1000)

stdout res, LF
exit 0
