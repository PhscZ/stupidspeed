# task 06 char_count — expected output: 10000000
# build: python 06_char_count.py | pypy 06_char_count.py | graalpy 06_char_count.py | nuitka --standalone 06_char_count.py    run: python 06_char_count.py
# note: the 100000000-character text is built once by repeating the 10-character block, never by appending.

text = 'abcdefghij' * 10000000

count = 0
for ch in text:
    if ch == 'a':
        pass
    elif ch == 'e':
        pass
    elif ch == 'h':
        count += 1
    else:
        pass

print(count)
