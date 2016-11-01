import $$observable from 'symbol-observable'

export defineObservable = (clazz, getter) ->
	Object.defineProperty(clazz.prototype, $$observable, {
		configurable: true
		enumerable: false
		writable: true
		value: getter
	})

export arrayRemove = (array, item) ->
	i = array.indexOf(item)
	if i isnt -1 then array.splice(i,1)
	undefined
