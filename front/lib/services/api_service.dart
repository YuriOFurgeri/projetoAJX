import 'dart:convert';
import 'package:front/models/additional.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';
import '../models/order.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:3333';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Category> categories = body.map((dynamic item) => Category.fromJson(item)).toList();
      return categories;
    } else {
      throw Exception('Erro ao carregar categorias');
    }
  }

  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Erro ao carrega produtos');
    }
  }

 Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/products?category_id=$categoryId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  Future<List<Additional>> fetchProductAdditionals(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId/additionals'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Additional.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar os adicionais');
    }
  }

  Future<void> createOrder(Order order) async {
    final url = Uri.parse('$baseUrl/orders');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar pedido');
    }
  }

}
