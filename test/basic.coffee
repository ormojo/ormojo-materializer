ormojo = require 'ormojo'
{ Store, View, Source, Stream } = require '..'
{ expect } = require 'chai'
{ store, view, JPHSource, source, corpus, Post } = require './TestView'
Observable = require 'any-observable'

describe 'basic tests', ->
	it 'should explode', ->
		new Promise (resolve, reject) ->
			Observable.from(source.getStream()).subscribe({
				next: (value) ->
					console.log "observed ", value
					if value is null
						console.log "store is ", view.store
						console.log "object 1 is ", view.store.get(1).dataValues
						resolve(null)
			})
			view.setQuery('hi')

	it 'should observe some stuff', ->
		Observable.from([1]).subscribe({
			next: (value) -> console.log(value)
		})
