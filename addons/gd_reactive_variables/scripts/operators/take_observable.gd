extends Observable
class_name TakeObservable

var _upstream: Observable
var _take_count: int

func _init(upstream: Observable, take_count: int) -> void:
	_upstream = upstream
	_take_count = take_count

func subscribe(callable: Callable) -> Subscription:
	if _take_count <= 0:
		var disposed_subscription := Subscription.new()
		disposed_subscription.dispose()
		return disposed_subscription
	
	var state := {
		"count": 0,
		"is_limit_reached": false,
		"upstream_subscription": null
	}
	
	state.upstream_subscription = _upstream.subscribe(
		func(value: Variant):
			if state.is_limit_reached:
				return
			
			state.count += 1
			callable.call(value)
			
			if state.count >= _take_count:
				state.is_limit_reached = true
				if state.upstream_subscription != null:
					state.upstream_subscription.dispose()
	)
	
	# ReactiveVariable などの購読開始と同時に発火するものの対策
	if state.is_limit_reached:
		state.upstream_subscription.dispose()
	
	return Subscription.new(state.upstream_subscription.dispose)
