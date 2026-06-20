extends Node
class_name SubscriptionManager

var _subscription_list : Array[Subscription]

## 破棄対象の[code]Subscription[/code]を追加
## [param subscription]: 破棄対象の[code]Subscription[/code]
func add_subscription(subscription: Subscription) -> void:
	if subscription.is_disposed \
		or subscription in _subscription_list:
		return
	_subscription_list.append(subscription)

func _exit_tree() -> void:
	for subscription in _subscription_list:
		subscription.dispose()
	_subscription_list.clear()
