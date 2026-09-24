# task 11 parallel_sum — expected output: 7500000075000000
# build: godot --headless --script 11_parallel_sum.gd    run: godot --headless --script 11_parallel_sum.gd
# note: four Godot Threads, each owning a fixed quarter of the range, joined with
#       wait_to_finish(). Godot's headless startup (about a second) swamps this task,
#       which RUN.md already documents.

extends SceneTree

func work(t: int) -> int:
	var acc := 0
	var start := t * 25000000
	var stop := (t + 1) * 25000000
	for i in range(start, stop):
		match i % 4:
			0:
				acc += 1
			1:
				acc += i
			2:
				acc += 2 * i
			3:
				acc += 3 * i
	return acc

func _initialize() -> void:
	var threads: Array[Thread] = []
	for t in 4:
		var thread := Thread.new()
		threads.append(thread)
		thread.start(Callable(self, "work").bind(t))
	var total := 0
	for t in 4:
		total += int(threads[t].wait_to_finish())
	print(total)
	quit()
