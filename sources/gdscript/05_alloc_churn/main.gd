# task 05 alloc_churn — expected output: 1274991808
# build: godot --headless --script main.gd    run: godot --headless --script main.gd
# note: PackedByteArray is a reference-counted value type, so storing into slots keeps the
#       fresh 64-byte buffer reachable and drops the buffer it replaces.

extends SceneTree

func _initialize() -> void:
	var total := 0
	var slots := []
	slots.resize(256)
	for i in 10000000:
		var buf := PackedByteArray()
		buf.resize(64)
		buf[0] = i % 256
		total += buf[0]
		slots[i % 256] = buf
	print(total)
	quit()
