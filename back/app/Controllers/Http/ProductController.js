'use strict'

const Product = use('App/Models/Product')

class ProductController {

    async index({ request, response }) {
      const categoryId = request.input('category_id')
      let query = Product.query()

      if (categoryId) {
        query = query.where('category_id', categoryId)
      }

      const products = await query.fetch()
      return response.json(products)
    }




  async showByCategory ({ params, response }) {
    const products = await Product.query().where('category_id', params.category_id).fetch()
    return response.json(products)
  }




  async store ({ request, response }) {
    const { name, description, price, image_url, category_id } = request.post()
    const product = await Product.create({ name, description, price, image_url, category_id })
    return response.status(201).json(product)
  }



  async update ({ params, request, response }) {
    const product = await Product.find(params.id)
    const { name, description, price, image_url, category_id } = request.post()

    if (!product) {
      return response.status(404).json({ message: 'Produto não encontrado.' })
    }

    product.name = name
    product.description = description
    product.price = price
    product.image_url = image_url
    product.category_id = category_id
    await product.save()

    return response.json(product)
  }




  async delete ({ params, response }) {
    const product = await Product.find(params.id)

    if (!product) {
      return response.status(404).json({ message: 'Produto não encontrado.' })
    }

    await product.delete()

    return response.status(204).json(null)
  }


  async show ({ params, response }) {
    try {
      const product = await Product.query()
        .with('additionals')
        .where('id', params.id)
        .firstOrFail()

      return response.status(200).json(product)
    } catch (error) {
      return response.status(404).json({ message: 'Produto não encontrado.' })
    }
  }
}

module.exports = ProductController
