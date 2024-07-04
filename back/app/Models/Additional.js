'use strict'

const Model = use('Model')

class Additional extends Model {


  product () {
    return this.belongsTo('App/Models/Product')
  }
}

module.exports = Additional
