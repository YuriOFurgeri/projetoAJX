'use strict'

const Route = use('Route')

Route.get('/categories', 'CategoryController.index');
Route.post('/categories', 'CategoryController.store')
Route.put('/categories/:id', 'CategoryController.update')
Route.delete('/categories/:id', 'CategoryController.delete')

Route.get('/products', 'ProductController.index')

Route.get('/products/:category_id', 'ProductController.showByCategory')
Route.post('/products', 'ProductController.store')
Route.put('/products/:id', 'ProductController.update')
Route.delete('/products/:id', 'ProductController.delete')



// Rota para criar um novo adicional associado a um produto
Route.post('products/:productId/additionals', 'AdditionalController.store')

Route.get('products/:productId/additionals', 'AdditionalController.index')




// Rota para criar um novo pedido
Route.post('orders', 'OrderController.store')

// Rota para visualizar um pedido específico
Route.get('orders/:id', 'OrderController.show')

Route.get('orders', 'OrderController.index')

