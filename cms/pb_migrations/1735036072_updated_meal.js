/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3120294188")

  // update collection data
  unmarshal({
    "name": "meals"
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3120294188")

  // update collection data
  unmarshal({
    "name": "meal"
  }, collection)

  return app.save(collection)
})
