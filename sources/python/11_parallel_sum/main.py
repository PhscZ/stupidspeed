# task 11 parallel_sum — expected output: 7500000075000000
# build: python main.py | pypy main.py | graalpy main.py | nuitka --standalone main.py    run: python main.py
# note: threading.Thread is the standard-library mechanism, but the GIL serializes these four workers, so the sum is right and the speedup is not real (use multiprocessing for that).

import threading

partials = [0, 0, 0, 0]


def work(t):
    acc = 0
    for i in range(t * 25000000, (t + 1) * 25000000):
        match i % 4:
            case 0:
                acc += 1
            case 1:
                acc += i
            case 2:
                acc += 2 * i
            case 3:
                acc += 3 * i
    partials[t] = acc


threads = [threading.Thread(target=work, args=(t,)) for t in range(4)]
for th in threads:
    th.start()
for th in threads:
    th.join()

print(sum(partials))
