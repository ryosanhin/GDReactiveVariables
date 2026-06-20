extends RefCounted
class_name Subscription

var _disposes: Array[Callable]

var _is_disposed := false
var is_disposed: bool:
	get: return _is_disposed

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

## 自動破棄登録
func add_to(node: Node) -> void:
	node.tree_exited.connect(dispose)
