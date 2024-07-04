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

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<List<Additional>> _additionalFuture;
  List<Additional> _selectedAdditionals = [];

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
        title: Text('Detalhes do Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
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
              widget.product.image_url,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Preço: R\$ ${widget.product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            FutureBuilder<List<Additional>>(
              future: _additionalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar adicionais: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Sem adicionais disponíveis'));
                }

                List<Additional> additionals = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adicionais:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
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
            SizedBox(height: 16),
            ElevatedButton(
              
              onPressed: () {
                CartItem cartItem = CartItem(
                  product: widget.product,
                  additional: _selectedAdditionals.isNotEmpty ? _selectedAdditionals.first : null,
                  quantity: 1,
                );
                Provider.of<CartProvider>(context, listen: false).addItem(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produto adicionado ao carrinho!')),
                );
              },
              style: ElevatedButton.styleFrom(
              
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                side: BorderSide(color: Colors.black, width: 2), // Borda do botão
              ),
              textStyle: TextStyle(
                fontSize: 24, // Tamanho do texto
                fontWeight: FontWeight.bold, // Peso do texto
              ),
            ),
              child: Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
