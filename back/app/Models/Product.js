'use strict'

const Model = use('Model')

class Product extends Model {
  category() {
    return this.belongsTo('App/Models/Category')
  }
  additionals () {
    return this.hasMany('App/Models/Additional')
  }
}

module.exports = Product

