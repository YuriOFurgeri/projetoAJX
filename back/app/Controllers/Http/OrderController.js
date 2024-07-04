'use strict'

const Order = use('App/Models/Order')
const OrderItem = use('App/Models/OrderItem')
const Payment = use('App/Models/Payment')
const Database = use('Database')

class OrderController {
  async store ({ request, response }) {
    const trx = await Database.beginTransaction()

    try {
      const { items, payment_method } = request.only(['items', 'payment_method'])

      const totalAmount = items.reduce((total, item) => total + (item.price * item.quantity), 0)

      const order = await Order.create({ status: 'pending', total_amount: totalAmount }, trx)

      for (const item of items) {
        await OrderItem.create({
          order_id: order.id,
          product_id: item.product_id,
          additional_id: item.additional_id,
          quantity: item.quantity,
          price: item.price,
        }, trx)
      }

      await Payment.create({
        order_id: order.id,
        payment_method,
        amount: totalAmount
      }, trx)

      await trx.commit()

      return response.status(201).json(order)
    } catch (error) {
      await trx.rollback()
      return response.status(500).json({ message: 'Erro ao criar o pedido.', error: error.message })
    }
  }





  async show ({ params, response }) {
    try {
      const order = await Order.query()
        .with('items.product')
        .with('items.additional')
        .with('payment')
        .where('id', params.id)
        .firstOrFail()

      return response.status(200).json(order)
    } catch (error) {
      return response.status(404).json({ message: 'Pedido não encontrado.' })
    }
  }






  async index ({ response }) {
    try {
      const orders = await Order.query()
        .with('items.product')
        .with('items.additional')
        .with('payment')
        .orderBy('created_at', 'desc')
        .fetch()

      return response.status(200).json(orders)
    } catch (error) {
      return response.status(500).json({ message: 'Erro ao buscar pedidos.', error: error.message })
    }
  }




}

module.exports = OrderController
