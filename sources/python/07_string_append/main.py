# task 07 string_append — expected output: 1000000
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

text = ''
for _ in range(1000000):
    text += 'x'

print(len(text))
