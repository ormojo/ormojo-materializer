import Observable from 'any-observable'
import { defineObservable, arrayRemove } from './Util'

export default class Stream
	constructor: (@source) ->

	viewWasAdded: (view) ->

	viewWasRemoved: (view) ->

	push: (value) ->
		for observer in (@observers or [])
			observer.next(value)

defineObservable(Stream, ->
	new Observable( (observer) =>
		@observers = (@observers or [])
		@observers.push(observer)
		return => arrayRemove(@observers, observer)
	)
)
