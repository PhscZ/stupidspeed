# task 07 string_append — expected output: 1000000
# build: python 07_string_append.py | pypy 07_string_append.py | graalpy 07_string_append.py | nuitka --standalone 07_string_append.py    run: python 07_string_append.py

text = ''
for _ in range(1000000):
    text += 'x'

print(len(text))
