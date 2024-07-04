'use strict'

const Model = use('Model')

class Order extends Model {
  static get table () {
    return 'orders'
  }

  items () {
    return this.hasMany('App/Models/OrderItem')
  }

  payment () {
    return this.hasOne('App/Models/Payment')
  }
}

module.exports = Order
