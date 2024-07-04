'use strict'

const Schema = use('Schema')

class OrdersTableSchema extends Schema {
  up () {
    this.create('orders', (table) => {
      table.increments()
      table.string('status').notNullable()
      table.decimal('total_amount', 12, 2).notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('orders')
  }
}

module.exports = OrdersTableSchema
