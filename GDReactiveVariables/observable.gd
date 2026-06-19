extends RefCounted
class_name Observable

## イベント発生時に発火させるシグナル
signal _on_next_emitted(value: Variant)

## イベント発行を終了させる
signal _on_complete_emitted

## 値の変更を購読[br]
## [param callable]: 購読時に実行するメソッド[br]
## returns: 購読破棄用の[code]Callable[/code]
func subscribe(callable: Callable) -> Subscription:
	_on_next_emitted.connect(callable)
	return Subscription.new(_unsubscribe.bind(callable))

## メソッドを選択しての購読の破棄[br]
## [param callable]: 解除したい購読のメソッド
func _unsubscribe(callable: Callable) -> void:
	if _on_next_emitted.is_connected(callable):
		_on_next_emitted.disconnect(callable)

## 値に処理を行う[br]
## [param transform]: 行うメソッド[br]
## returns: 新しい[code]Observable[/code]
func map(transform: Callable) -> Observable:
	return MapObservable.new(self, transform)

## 値にフィルタリングを行う[br]
## [param predicate]: フィルタリング用のメソッド、[code]bool[/code]を返す[br]
## returns: 新しい[code]Observable[/code]
func filter(predicate: Callable) -> Observable:
	return FilterObservable.new(self, predicate)

## 同一の値の出力を除外[br]
## returns: 新しい[code]Observable[/code]
func distinct_until_changed() -> Observable:
	return DistinctUntilChangedObservable.new(self)
