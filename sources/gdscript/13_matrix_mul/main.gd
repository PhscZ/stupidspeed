# task 13 matrix_mul — expected output: 599995000
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: plain i, j, k triple loop in that order, no reordering and no library multiply.

extends SceneTree

func _initialize() -> void:
	var n := 500
	var size := n * n
	var a := PackedInt64Array()
	a.resize(size)
	var b := PackedInt64Array()
	b.resize(size)
	var c := PackedInt64Array()
	c.resize(size)
	for i in n:
		for j in n:
			a[i * n + j] = (i + j) % 7
			b[i * n + j] = (i * j) % 5
	for i in n:
		for j in n:
			var sum := 0
			for k in n:
				sum += a[i * n + k] * b[k * n + j]
			c[i * n + j] = sum
	var total := 0
	for i in size:
		total += c[i]
	print(total)
	quit()
