extends RefCounted
class_name Subscription

var _disposes: Array[Callable] = []

var _is_disposed := false
var is_disposed: bool:
	get: return _is_disposed

## [params disposes]: 購読の解除用メソッド（可変長変数）
func _init(...disposes) -> void:
	_disposes.append_array(disposes as Array[Callable])

## 購読破棄
func dispose() -> void:
	if _is_disposed:
		return
	
	_is_disposed = true
	
	for d in _disposes:
		if d.is_valid():
			d.call()
	_disposes.clear()
