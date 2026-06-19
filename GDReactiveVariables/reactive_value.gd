extends Observable
class_name ReactiveValue

var _value: Variant

var value: Variant:
	get:
		return _value
	set(new_value):
		if _value != new_value:
			_value = new_value
			_on_next_emitted.emit(_value)

func _init(init_value: Variant) -> void:
	_value = init_value

func subscribe(callable: Callable) -> Subscription:
	var unsub_callable := super.subscribe(callable)
	callable.call(_value)
	return unsub_callable
