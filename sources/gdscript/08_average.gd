# task 08 average — expected output: 0.498046875
# build: godot --headless --script 08_average.gd    run: godot --headless --script 08_average.gd
# note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is
#       exact and the printed digits are identical in every language.
# note: GDScript walks these 100 M-iteration loops very slowly; expect a long run.

extends SceneTree

func _initialize() -> void:
	var total := 0.0
	for i in 100000000:
		var reading := float(i % 256) / 256.0
		total += reading
	print(total / 100000000.0)
	quit()
