'use strict'

const Model = use('Model')

class OrderItem extends Model {
  product () {
    return this.belongsTo('App/Models/Product')
  }

  order () {
    return this.belongsTo('App/Models/Order')
  }

  additional () {
    return this.belongsTo('App/Models/Additional')
  }
}

module.exports = OrderItem
