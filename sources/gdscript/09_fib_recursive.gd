# task 09 fib_recursive — expected output: 102334155
# build: godot --headless --script 09_fib_recursive.gd    run: godot --headless --script 09_fib_recursive.gd
# note: naive fib(40) is about 331 million calls, which is very slow in GDScript.

extends SceneTree

func fib(n: int) -> int:
	if n < 2:
		return n
	return fib(n - 1) + fib(n - 2)

func _initialize() -> void:
	print(fib(40))
	quit()
