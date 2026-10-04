# task 07 string_append — expected output: 250000
# build: godot --headless --script 07_string_append.gd    run: godot --headless --script 07_string_append.gd
# note: this is Godot's own String concatenation, not a growable byte buffer.

extends SceneTree

func _initialize() -> void:
	var t0 := Time.get_ticks_msec()
	var text := ""
	for _i in 250000:
		text += "x"
	printerr("TIME_MS=%d" % (Time.get_ticks_msec() - t0))
	print(text.length())
	quit()
