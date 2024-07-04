'use strict'

const Schema = use('Schema')

class OrderItemsTableSchema extends Schema {
  up () {
    this.create('order_items', (table) => {
      table.increments()
      table.integer('order_id').unsigned().references('id').inTable('orders')
      table.integer('product_id').unsigned().references('id').inTable('products')
      table.integer('additional_id').unsigned().references('id').inTable('additionals')
      table.integer('quantity').notNullable()
      table.decimal('price', 12, 2).notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('order_items')
  }
}

module.exports = OrderItemsTableSchema
