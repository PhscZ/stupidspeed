# task 06 char_count — expected output: 10000000
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: the 100 MB text is built once by repeat(), then scanned by index; the scan is
#       100 M iterations and may hit the 300 s timeout in GDScript.

extends SceneTree

func _initialize() -> void:
	var text := "abcdefghij".repeat(10000000)
	var count := 0
	for i in text.length():
		if text[i] == "h":
			count += 1
	print(count)
	quit()
