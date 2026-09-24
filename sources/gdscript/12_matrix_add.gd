# task 12 matrix_add — expected output: 999000000
# build: godot --headless --script 12_matrix_add.gd    run: godot --headless --script 12_matrix_add.gd
# note: flat PackedInt64Array arrays addressed as i * n + j.

extends SceneTree

func _initialize() -> void:
	var n := 1000
	var size := n * n
	var a := PackedInt64Array()
	a.resize(size)
	var b := PackedInt64Array()
	b.resize(size)
	var c := PackedInt64Array()
	c.resize(size)
	for i in n:
		for j in n:
			a[i * n + j] = i + j
			b[i * n + j] = i - j
	for i in n:
		for j in n:
			c[i * n + j] = a[i * n + j] + b[i * n + j]
	var total := 0
	for i in size:
		total += c[i]
	print(total)
	quit()
