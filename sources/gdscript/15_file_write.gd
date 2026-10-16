# task 15 file_write — expected output: 419430400
# build: godot --headless --script 15_file_write.gd    run: godot --headless --script 15_file_write.gd
# note: out.bin is written to the project directory, 1 MiB at a time; 8 passes each seek
#       back to offset 0 and write the buffer 50 times, then flush; the printed count is the
#       total written across all passes.

extends SceneTree

func _initialize() -> void:
	var t0 := Time.get_ticks_msec()
	var buf := PackedByteArray()
	buf.resize(1048576)
	for i in 1048576:
		buf[i] = i % 256
	var f := FileAccess.open("out.bin", FileAccess.WRITE)
	if f == null:
		quit(1)
		return
	var written := 0
	for _p in 8:
		f.seek(0)
		for _i in 50:
			f.store_buffer(buf)
		f.flush()
		written += 50 * 1048576
	f.close()
	printerr("TIME_MS=%d" % (Time.get_ticks_msec() - t0))
	print(written)
	quit()
