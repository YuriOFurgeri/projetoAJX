'use strict'

const Additional = use('App/Models/Additional')

class AdditionalController {




  async store ({ params, request, response }) {
    try {
      const productId = params.productId
      const data = request.only(['addoption','notes'])

      const additional = await Additional.create({ product_id: productId, ...data })

      return response.status(201).json(additional)
    } catch (error) {
      return response.status(400).json({ message: 'Erro ao criar o adicional.' })
    }
  }




  async index ({ params, response }) {
    try {
      const productId = params.productId

      const additionals = await Additional.query()
        .where('product_id', productId)
        .fetch()

      return response.status(200).json(additionals)
    } catch (error) {
      return response.status(500).json({ message: 'Erro ao buscar adicionais.' })
    }
  }
}

module.exports = AdditionalController
