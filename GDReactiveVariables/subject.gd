extends Observable
class_name Subject

## 引数でイベントを発火
func on_next(value: Variant) -> void:
	_on_next_emitted.emit(value)

## 購読を発行側から終了させる
func on_complete() -> void:
	_on_complete_emitted.emit()
