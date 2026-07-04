extends Observable
class_name MapObservable

var _upstream: Observable
var _transform: Callable

func _init(upstream: Observable, transform: Callable) -> void:
	_upstream = upstream
	_transform = transform

func subscribe(callable: Callable) -> Subscription:
	var upstream_subscription :=  _upstream.subscribe(
		func(value: Variant):
			callable.call(
				_transform.call(value)
			)
	)
	
	return Subscription.new(upstream_subscription.dispose)
