# task 03 func_sum — expected output: 100000000
# build: godot --headless --script 03_func_sum.gd    run: godot --headless --script 03_func_sum.gd
# note: GDScript has no JIT and no inliner, so a plain function is never folded away.
# note: GDScript walks these 100 M-iteration loops very slowly and may hit the 300 s timeout.

extends SceneTree

func add_one(n: int) -> int:
	return n + 1

func _initialize() -> void:
	var value := 0
	for _i in 100000000:
		value = add_one(value)
	print(value)
	quit()
