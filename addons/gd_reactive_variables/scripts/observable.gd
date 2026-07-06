extends RefCounted
class_name Observable

## イベント発生時に発火させるシグナル
signal _on_next_emitted(value: Variant)

## イベント発行を終了させる
signal _on_complete_emitted

## 値の変更を購読[br]
## [param callable]: 購読時に実行するメソッド[br]
## returns: 購読情報を保持する[code]Subscription[/code]
func subscribe(callable: Callable) -> Subscription:
	_on_next_emitted.connect(callable)
	return Subscription.new(_unsubscribe.bind(callable))

## 次に発行される値を一度だけ待機[br]
## returns: 次に発行された値
func await_next() -> Variant:
	return await _on_next_emitted

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

## 指定した回数だけ購読をスキップ[br]
## [param count]: スキップ回数
## returns: 新しい[code]Observable[/code]
func skip(count: int) -> Observable:
	return SkipObservable.new(self, count)

## 指定した回数だけ購読して自動的に購読解除[br]
## [param count]: 購読する回数
## returns: 新しい[code]Observable[/code]
func take(count: int) -> Observable:
	return TakeObservable.new(self, count)

## 直前の値と現在の値を組にして出力[br]
## returns: 新しい[code]Observable[/code]
func pairwise() -> Observable:
	return PairwiseObservable.new(self)


## 直前の値と現在の値を組にして購読[br]
## 初回は直前の値として[code]null[/code]を返す
## returns: 新しい[code]Observable[/code]
func pairwise_nullable() -> Observable:
	return PairwiseNullableObservable.new(self)
