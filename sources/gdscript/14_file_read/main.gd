# task 14 file_read — expected output: 484442112
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: data.bin is read from the project directory in 1 MiB chunks; the byte loop is
#       100 M iterations and may hit the 300 s timeout in GDScript.

extends SceneTree

func _initialize() -> void:
	var f := FileAccess.open("data.bin", FileAccess.READ)
	if f == null:
		quit(1)
		return
	var total := 0
	while not f.eof_reached():
		var buf := f.get_buffer(1048576)
		var count := buf.size()
		if count == 0:
			break
		for i in count:
			total += buf[i]
	f.close()
	print(total % 4294967296)
	quit()
