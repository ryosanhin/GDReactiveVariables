extends Node

var _health := ReactiveVariable.new(100.0)
var health: ReadOnlyReactiveVariable:
	get:
		return _health

func _ready() -> void:
	health.filter(func(v): return v > 50.0) \
		.skip(1) \
		.map(func(v): return "HP" + str(v)) \
		.subscribe(func(msg): print(msg)) \
		.add_to(self)
	
	health.filter(func(v): return v < 50.0) \
		.map(func(v): return "Warning! HP" + str(v)) \
		.subscribe(func(msg): print(msg)) \
		.add_to(self)
	
	print("-----start test-----")
	
	_health.value = 90.0
	
	_health.value = 70.0
	
	_health.value = 40.0
	
	_health.value = 10.0
	
	print("-----finish test-----")
	
	await get_tree().create_timer(5).timeout
	
	queue_free()
