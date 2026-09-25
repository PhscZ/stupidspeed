# task 02 switch_case — expected output: 7500000075000000
# build: godot --headless --script 02_switch_case.gd    run: godot --headless --script 02_switch_case.gd
# note: GDScript walks these 100 M-iteration loops very slowly; expect a long run.

extends SceneTree

func _initialize() -> void:
	var acc := 0
	for i in 100000000:
		match i % 4:
			0:
				acc += 1
			1:
				acc += i
			2:
				acc += 2 * i
			3:
				acc += 3 * i
	print(acc)
	quit()
