import { BoundModel, createStandardInstanceClassForBoundModel } from 'ormojo'

export default class MVBoundModel extends BoundModel
	constructor: ->
		super
		@instanceClass = createStandardInstanceClassForBoundModel(@)

	find: ->
		throw new Error('find is unimplemented by default for materialized views')

	findAll: ->
		throw new Error('find is unimplemented by default for materialized views')
