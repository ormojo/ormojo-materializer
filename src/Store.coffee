import IdSet from './IdSet'

export default class Store
	constructor: ->
		@data = new Map
		@set = new IdSet

	get: (id) ->
		@data.get(id)

	put: (id, val) ->
		@data.set(id, val)
		@set.add(id)

	delete: (id) ->
		@data.delete(id)
		@set.remove(id)
