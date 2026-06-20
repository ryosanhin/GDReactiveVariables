extends Observable
class_name SkipObservable

var _upstream: Observable
var _skip_count: int

func _init(upstream: Observable, skip_count: int) -> void:
	_upstream = upstream
	_skip_count = skip_count

func subscribe(callable: Callable) -> Subscription:
	var state := {
		"count": _skip_count
	}
	
	var upstream_subscription :=  _upstream.subscribe(
		func(value: Variant):
			if state.count > 0:
				state.count-=1
				return
			callable.call(value)
	)
	
	return Subscription.new(upstream_subscription.dispose)
