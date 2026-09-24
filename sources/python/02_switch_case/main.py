# task 02 switch_case — expected output: 7500000075000000
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py

acc = 0

for i in range(100000000):
    match i % 4:
        case 0:
            acc += 1
        case 1:
            acc += i
        case 2:
            acc += 2 * i
        case 3:
            acc += 3 * i

print(acc)
