'use strict'

const Schema = use('Schema')

class AdditionalsTableSchema extends Schema {
  up () {
    this.create('additionals', (table) => {
      table.increments()
      table.integer('product_id').unsigned().references('id').inTable('products').onDelete('CASCADE')

      table.boolean('addoption').defaultTo(false)

      table.string('notes')
      table.timestamps()
    })
  }

  down () {
    this.drop('additionals')
  }
}

module.exports = AdditionalsTableSchema
