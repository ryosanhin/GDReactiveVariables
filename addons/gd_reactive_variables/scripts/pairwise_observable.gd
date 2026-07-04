extends Observable
class_name PairwiseObservable

var _upstream: Observable

func _init(upstream: Observable) -> void:
	_upstream = upstream

func subscribe(callable: Callable) -> Subscription:
	var state := {
		"has_previous": false,
		"previous_value": null
	}
	
	var upstream_subscription := _upstream.subscribe(
		func(value: Variant):
			if not state.has_previous:
				state.has_previous = true
				state.previous_value = value
				return
			
			callable.call({
				"prev": state.previous_value,
				"current": value
			})
			
			state.previous_value = value
	)
	
	return Subscription.new(upstream_subscription.dispose)
