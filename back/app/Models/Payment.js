'use strict'

const Model = use('Model')

class Payment extends Model {
  order () {
    return this.belongsTo('App/Models/Order')
  }
}

module.exports = Payment
