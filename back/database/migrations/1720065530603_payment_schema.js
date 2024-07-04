'use strict'

const Schema = use('Schema')

class PaymentsTableSchema extends Schema {
  up () {
    this.create('payments', (table) => {
      table.increments()
      table.integer('order_id').unsigned().references('id').inTable('orders')
      table.string('payment_method').notNullable()
      table.decimal('amount', 12, 2).notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('payments')
  }
}

module.exports = PaymentsTableSchema
