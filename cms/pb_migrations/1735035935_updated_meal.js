/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3120294188")

  // add field
  collection.fields.addAt(4, new Field({
    "hidden": false,
    "id": "number3402113753",
    "max": null,
    "min": 0,
    "name": "price",
    "onlyInt": false,
    "presentable": false,
    "required": true,
    "system": false,
    "type": "number"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3120294188")

  // remove field
  collection.fields.removeById("number3402113753")

  return app.save(collection)
})
