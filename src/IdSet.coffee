# A utility class maintaining a simultaneous hash and array of ids.
export default class IdSet
	constructor: ->
		@set = new Map; @list = []

	add: (id) ->
		if @set.has(id) then return false
		@set.set(id, true); @list.push(id); true

	remove: (id) ->
		if not @set.has(id) then return false
		@set.delete(id)
		i = @list.indexOf(id)
		@list.splice(i, 1)
