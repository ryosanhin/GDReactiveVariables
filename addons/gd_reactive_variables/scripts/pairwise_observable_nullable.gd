extends Observable
class_name PairwiseNullableObservable

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
				callable.call({
					"prev": null,
					"current": value
				})
				state.previous_value = value
				state.has_previous = true
				return
			
			callable.call({
				"prev": state.previous_value,
				"current": value
			})
			state.previous_value = value
	)
	
	return Subscription.new(upstream_subscription.dispose)
