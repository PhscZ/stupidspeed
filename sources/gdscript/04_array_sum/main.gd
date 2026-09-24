# task 04 array_sum — expected output: 499999500000
# build: godot --headless --script main.gd    run: godot --headless --script main.gd

extends SceneTree

func _initialize() -> void:
	var n := 1000000
	var values := PackedInt64Array()
	values.resize(n)
	for i in n:
		values[i] = i
	var total := 0
	for i in n:
		total += values[i]
	print(total)
	quit()
