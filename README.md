# ormojo-materializer
Provides an ormojo backend that creates materialized views of another data store.

## Concepts

### View

A `View` is an `ormojo.Backend` specialized to keep a collection of `ormojo.BoundInstance`s matching an associated `ormojo.Query`.

- `View`s are `Observable` -- clients may observe the `View` to update UI, for instance.

### Source

A `Source` is an abstract endpoint from which data flows. The local cache backing a materialized view would be a `Source`, as would the remote database the `View` is ultimately pulling from.

### Stream

A `Stream` is an asynchronous flow of content from a `Source` to a `View`, or another `Source`. `Streams` are also `Observable`s.

### Store

A `Store` is a simple key-value store used as a cache by the `View`. Generally this will be an in-memory cache, though it doesn't need to be.

## Required JavaScript Features / Polyfills

Your runtime or transpiler toolchain will need to support the following JavaScript features in order to build and run this library:

- `Object.defineProperty`
- `Object.assign`
- `Map`
- `Observable`. We use [any-observable](https://www.npmjs.com/package/any-observable) to select an appropriate observable library; you may register your preferred library in advance if you want a particular implementation.

All of these polyfills are available in [core-js](https://www.npmjs.com/package/core-js)
