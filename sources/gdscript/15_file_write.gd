# task 15 file_write — expected output: 104857600
# build: godot --headless --script 15_file_write.gd    run: godot --headless --script 15_file_write.gd
# note: out.bin is written to the project directory, 1 MiB at a time, then flushed and
#       closed; the printed count is the file position after the writes.

extends SceneTree

func _initialize() -> void:
	var buf := PackedByteArray()
	buf.resize(1048576)
	for i in 1048576:
		buf[i] = i % 256
	var f := FileAccess.open("out.bin", FileAccess.WRITE)
	if f == null:
		quit(1)
		return
	for _i in 100:
		f.store_buffer(buf)
	f.flush()
	var written := f.get_position()
	f.close()
	print(written)
	quit()
