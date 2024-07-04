'use strict'

const Category = use('App/Models/Category')

class CategoryController {


  async index ({ response }) {
    const categories = await Category.all()
    return response.json(categories)
  }



  async store ({ request, response }) {
    const data = request.only(['name', 'image_url'])
    const category = await Category.create(data)
    return response.status(201).json(category)
  }



  async show ({ params, response }) {
    const category = await Category.find(params.id)
    return response.json(category)
  }



  async update ({ params, request, response }) {
    const category = await Category.find(params.id)
    const data = request.only(['name', 'image_url'])

    category.merge(data)
    await category.save()
    return response.json(category)
  }



  async destroy ({ params, response }) {
    const category = await Category.find(params.id)
    await category.delete()
    return response.status(204).json(null)
  }
}

module.exports = CategoryController
