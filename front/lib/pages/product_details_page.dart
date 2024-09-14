import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/additional.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final ApiService apiService = ApiService();

  ProductDetailsPage({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<List<Additional>> _additionalFuture;
  final List<Additional> _selectedAdditionals = [];

  @override
  void initState() {
    super.initState();
    _additionalFuture = widget.apiService.fetchProductAdditionals(widget.product.id);
  }

  void _toggleAdditional(Additional additional) {
    setState(() {
      if (_selectedAdditionals.contains(additional)) {
        _selectedAdditionals.remove(additional);
      } else {
        _selectedAdditionals.add(additional);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Preço: R\$ ${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Additional>>(
              future: _additionalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar adicionais: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Sem adicionais disponíveis'));
                }

                List<Additional> additionals = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adicionais:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (var additional in additionals)
                      CheckboxListTile(
                        title: Text('${additional.notes} ${additional.addoption ? '' : ''}'),
                        value: _selectedAdditionals.contains(additional),
                        onChanged: (bool? value) {
                          _toggleAdditional(additional);
                        },
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              
              onPressed: () {
                CartItem cartItem = CartItem(
                  product: widget.product,
                  additional: _selectedAdditionals.isNotEmpty ? _selectedAdditionals.first : null,
                  quantity: 1,
                );
                Provider.of<CartProvider>(context, listen: false).addItem(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produto adicionado ao carrinho!')),
                );
              },
              style: ElevatedButton.styleFrom(
              
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black, width: 2),
              ),
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold, 
              ),
            ),
              child: const Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
