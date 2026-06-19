extends Observable
class_name FilterObservable

var _upstream : Observable
var _predicate : Callable

func _init(upstream: Observable, predicate: Callable) -> void:
	_upstream = upstream
	_predicate = predicate

func subscribe(callable: Callable) -> Subscription:
	var upstream_subscription := _upstream.subscribe(
		func(value: Variant):
			if _predicate.call(value):
				callable.call(value)
	)
	
	return Subscription.new(upstream_subscription.dispose)
