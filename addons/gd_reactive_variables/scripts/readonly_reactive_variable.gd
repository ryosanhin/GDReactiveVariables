extends Observable
class_name ReadOnlyReactiveVariable

## 現在の値を取得、継承先でオーバーライド前提
func get_value() -> Variant:
	assert(false, "get_value method must be overridden.")
	pass

func subscribe(callable: Callable) -> Subscription:
	var subscription := super.subscribe(callable)
	callable.call(get_value())
	return subscription