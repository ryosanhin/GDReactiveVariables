extends RefCounted
class_name Subscription

var _disposes: Array[Callable]

var _is_disposed := false
## この購読が破棄されているか
var is_disposed: bool:
	get: return _is_disposed

const META_KEY := "__subscription_manager__"

## [params disposes]: 購読の解除用メソッド（可変長変数）
func _init(...disposes) -> void:
	_disposes.assign(disposes)

## 購読破棄
func dispose() -> void:
	if _is_disposed:
		return
	
	_is_disposed = true
	for d in _disposes:
		if d.is_valid():
			d.call()
	_disposes.clear()
	print("disposed")

## 自動破棄登録
func add_to(node: Node) -> void:
	var manager := _find_subscription_manager(node)
	manager.add_subscription(self)

## [code]node[/code]の子ノードから[code]SubscriptionManager[/code]を探す[br]
## [param node]: 紐づけ対象の[code]node[/code][br]
## returns: そのノードの[code]SubscriptionManager[/code]
func _find_subscription_manager(node: Node) -> SubscriptionManager:
	var manager: SubscriptionManager = (
		node.get_meta(META_KEY) if node.has_meta(META_KEY) else null
	)
	
	if is_instance_valid(manager):
		return manager
	
	var new_manager := SubscriptionManager.new()
	node.add_child(new_manager)
	node.set_meta(META_KEY, new_manager)
	return new_manager
