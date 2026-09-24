# task 07 string_append — expected output: 1000000
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: this is Godot's own String concatenation, not a growable byte buffer.

extends SceneTree

func _initialize() -> void:
	var text := ""
	for _i in 1000000:
		text += "x"
	print(text.length())
	quit()
