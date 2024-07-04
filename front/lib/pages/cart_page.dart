import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../services/api_service.dart';
import '../models/order.dart';

class CartPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    CartItem item = cart.items[index];
                    return ListTile(
                      title: Text(item.product.name),
                      subtitle: Text('Quantidade: ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('R\$ ${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cart.removeItem(item);
                            },
                          ),
                        ],
                      ),
                      leading: Image.network(
                        item.product.image_url,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Order order = Order(
                      items: cart.items.map((item) => OrderItem(
                        product_id: item.product.id,
                        additional_id: item.additional?.id,
                        quantity: item.quantity,
                        price: item.product.price,
                      )).toList(),
                      payment_method: 'credit_card',  // Exemplo de método de pagamento
                    );

                    await apiService.createOrder(order);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Pedido realizado com sucesso!'),
                    ));

                    cart.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Erro ao realizar pedido: $e'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Finalizar Pedido'),
              ),
            ],
          );
        },
      ),
    );
  }
}
