# task 04 array_sum — expected output: 599999940000000
# build: godot --headless --script 04_array_sum.gd    run: godot --headless --script 04_array_sum.gd

extends SceneTree

func _initialize() -> void:
	var t0 := Time.get_ticks_msec()
	var n := 10000000
	var values := PackedInt64Array()
	values.resize(n)
	for i in n:
		values[i] = i
	var total := 0
	for _pass in 12:
		for i in n:
			total += values[i]
	printerr("TIME_MS=%d" % (Time.get_ticks_msec() - t0))
	print(total)
	quit()
