# task 01 branches — expected output: 33333334 13333333 7619048 45714285
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: GDScript walks these 100 M-iteration loops very slowly and may hit the 300 s timeout.

extends SceneTree

func _initialize() -> void:
	var a := 0
	var b := 0
	var c := 0
	var d := 0
	for i in 100000000:
		if i % 3 == 0:
			a += 1
		elif i % 5 == 0:
			b += 1
		elif i % 7 == 0:
			c += 1
		else:
			d += 1
	print("%d %d %d %d" % [a, b, c, d])
	quit()
