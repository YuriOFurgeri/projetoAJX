'use strict'

const Category = use('App/Models/Category')
const Product = use('App/Models/Product')
const Additional = use('App/Models/Additional')

class DatabaseSeeder {
  async run () {
    const carne = await Category.create({
      name: 'Pasteis de Carne',
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0'
    })

    const frango = await Category.create({
      name: 'Pasteis de Frango',
      image_url: 'https://th.bing.com/th/id/OIP.somZAs0XkpgBHKIpywzfaQHaE8?rs=1&pid=ImgDetMain'
    })

    const doce = await Category.create({
      name: 'Pasteis Doces',
      image_url: 'https://th.bing.com/th/id/OIP.unz1pXZTzXLm2pY5vfN_ywHaE6?rs=1&pid=ImgDetMain'
    })

    const bebida = await Category.create({
      name: 'Bebidas',
      image_url: 'https://cdn.dooca.store/418/products/coca.jpg?v=1589835707&webp=0'
    })


    const pastelCarne = await Product.create({
      name: 'Pastel de Carne Simples',
      description: 'Carne moída',
      price: 9.99,
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0',
      category_id: carne.id,
    })

    const pastelCarneQueijo = await Product.create({
      name: 'Pastel de Carne com Queijo',
      description: 'Carne moída, Queijo Mussarela',
      price: 10.99,
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0',
      category_id: carne.id,
    })

    const pastelCarneBacon = await Product.create({
      name: 'Pastel de Carne com Bacon',
      description: 'Carne moída, Bacon em cubos',
      price: 10.99,
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0',
      category_id: carne.id,
    })

    const pastelCarneCalabresa = await Product.create({
      name: 'Pastel de Carne com Calabresa',
      description: 'Carne moída, Calabresa em cubos',
      price: 10.99,
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0',
      category_id: carne.id,
    })

    const pastelCarneMix = await Product.create({
      name: 'Pastel de Carne com bacon e brócolis',
      description: 'Carne moída, bacon, brócolis',
      price: 11.99,
      image_url: 'https://th.bing.com/th/id/R.abfaf3a3cbbb9c7703b8cfc60b55a9ed?rik=Mfqx%2bYmtYxcLTg&pid=ImgRaw&r=0',
      category_id: carne.id,
    })

    const pastelFrango = await Product.create({
      name: 'Pastel de Frango Simples',
      description: 'Frango desfiado',
      price: 9.99,
      image_url: 'https://th.bing.com/th/id/OIP.somZAs0XkpgBHKIpywzfaQHaE8?rs=1&pid=ImgDetMain',
      category_id: frango.id,
    })

    const pastelFrangoQueijo = await Product.create({
      name: 'Pastel de Frango com queijo',
      description: 'Frango desfiado, mussarela',
      price: 9.99,
      image_url: 'https://th.bing.com/th/id/OIP.somZAs0XkpgBHKIpywzfaQHaE8?rs=1&pid=ImgDetMain',
      category_id: frango.id,
    })

    const pastelChocolate = await Product.create({
      name: 'Pastel de Chocolate',
      description: 'Chocolate ao leite.',
      price: 11.99,
      image_url: 'https://th.bing.com/th/id/OIP.unz1pXZTzXLm2pY5vfN_ywHaE6?rs=1&pid=ImgDetMain',
      category_id: doce.id,
    })

    const cocaLata = await Product.create({
      name: 'Coca-Cola Lata',
      description: 'Lata 350ml',
      price: 5.99,
      image_url: 'https://cdn.dooca.store/418/products/coca.jpg?v=1589835707&webp=0',
      category_id: bebida.id,
    })


    await Additional.create({
      product_id: 1,
      addoption:false,
      notes: 'Opção com carne vegana'
    })
    await Additional.create({
      product_id: 2,
      addoption:false,
      notes: 'Opção com carne vegana'
    })
    await Additional.create({
      product_id: 3,
      addoption:false,
      notes: 'Opção com carne vegana'
    })
    await Additional.create({
      product_id: 9,
      addoption:false,
      notes: 'Opção de copo com gelo'
    })
  }
}

module.exports = DatabaseSeeder
