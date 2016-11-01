import Observable from 'any-observable'
import { defineObservable, arrayRemove } from './Util'
import MVBoundModel from './MVBoundModel'
import { Backend } from 'ormojo'

export default class View extends Backend
	constructor: (@store) ->
		@streams = new Map
		@query = null

	_bindModel: (clazz, model, bindingOptions) ->
		bm = new clazz(model, @, bindingOptions)
		bm

	bindModel: (model, bindingOptions) ->
		@_bindModel(MVBoundModel, model, bindingOptions)

	addStream: (stream, opts = {}) ->
		materializer = opts.materializer
		subscription = Observable.from(stream).subscribe({
			next: (value) =>
				if value?.data
					materializer(value, @, stream)
				else
					@materialized(stream, value)
		})
		@streams.set(stream, subscription)
		stream.viewWasAdded?(@)
		@

	removeStream: (stream) ->
		subscription = @streams.get(stream)
		if not subscription? then return undefined
		subscription.unsubscribe()
		@streams.delete(stream)
		stream.viewWasRemoved?(@)
		@

	setQuery: (query) ->
		prevQuery = @query; @query = query
		@streams.forEach( (v, stream) -> stream.source?.setQuery(@, query, prevQuery) )
		@

	# Invoked when a stream is done sending values. This is a good time to, e.g, sort the
	# view. Also, the stream may pass along pagination data.
	materialized: (stream, value) ->


defineObservable(View, ->
	new Observable( (observer) =>
		@observers = (@observers or [])
		@observers.push(observer)
		return => arrayRemove(@observers, observer)
	)
)
