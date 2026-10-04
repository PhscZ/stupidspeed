# task 03 func_sum — expected output: 100000000
# build: godot --headless --script 03_func_sum.gd    run: godot --headless --script 03_func_sum.gd
# note: GDScript has no JIT and no inliner, so a plain function is never folded away.
# note: GDScript walks these 100 M-iteration loops very slowly; expect a long run.

extends SceneTree

func add_one(n: int) -> int:
	return n + 1

func _initialize() -> void:
	var t0 := Time.get_ticks_msec()
	var value := 0
	for _i in 100000000:
		value = add_one(value)
	printerr("TIME_MS=%d" % (Time.get_ticks_msec() - t0))
	print(value)
	quit()
