extends Observable
class_name DistinctUntilChangedObservable

var _upstream: Observable

func _init(upstream: Observable) -> void:
	_upstream = upstream

func subscribe(callable: Callable) -> Subscription:
	var state := {
		"has_value": false,
		"last_value": null
	}
	
	var upstream_subscription := _upstream.subscribe(
		func(value: Variant):
			if not state.has_value:
				state.has_value = true
				state.last_value = value
				callable.call(value)
				return
			
			if state.last_value != value:
				state.last_value = value
				callable.call(value)
	)
	
	return Subscription.new(upstream_subscription.dispose)
