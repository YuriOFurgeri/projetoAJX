'use strict'

const Model = use('Model')

class Category extends Model {
  static get visible () {
    return ['id', 'name', 'image_url']
  }
}

module.exports = Category
