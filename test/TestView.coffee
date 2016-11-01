ormojo = require 'ormojo'
{ Store, View, Source, Stream } = require '..'
{ fetch, Request, Response, Headers } = (require 'fetch-ponyfill')()

store = new Store
view = new View(store)

class JPHSource extends Source
	constructor: ->
		@stream = new Stream(@)

	getStream: -> @stream

	setQuery: ->
		console.log 'fetching'
		fetch("http://jsonplaceholder.typicode.com/posts")
		.then (resp) ->
			resp.json()
		.then (objs) =>
			@stream.push({data: objs})
			@stream.push(null)
		.catch (err) ->
			console.log 'FETCH error ', err

source = new JPHSource

corpus = new ormojo.Corpus({
	log: {
		trace: console.log.bind(console)
	}
	backends: {
		'main': view
	}
})

Post = corpus.createModel({
	name: 'post'
	fields: {
		id: { type: ormojo.INTEGER }
		userId: { type: ormojo.INTEGER }
		title: { type: ormojo.STRING }
		body: { type: ormojo.STRING }
	}
}).forBackend('main')

view.addStream(source.getStream(), {
	materializer: (value, vw, stream) ->
		for item in value.data
			post = Post.createRaw(item)
			vw.store.put(post.id, post)
})

module.exports = {
	store, view, JPHSource, source, corpus, Post
}
