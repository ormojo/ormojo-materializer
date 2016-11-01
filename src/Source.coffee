import Observable from 'any-observable'

export default class Source
	constructor: ->

	# Get the observable to which this Source's results will be pushed.
	getStream: ->

	# Set the query designed to fetch data from this Source.
	setQuery: ->

	# Set an observable which will update the query.
	setQueryStream: (obs) ->
		Observable.from(obs).subscribe({
			next: (query) => @setQuery(query)
		})
