import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_list_page.dart';
import 'cart_page.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final ApiService apiService = ApiService();
  List<Category> _categories = [];
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchAllProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchCategories() async {
    try {
      List<Category> categories = await apiService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print(e);
    }
  }

  void _fetchAllProducts() async {
    try {
      List<Product> products = await apiService.fetchAllProducts();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    } catch (e) {
      print(e);
    }
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return (product.name.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação AJX'),
        centerTitle: true,

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

            Container(
            height: 120, 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://th.bing.com/th/id/OIP.unz1pXZTzXLm2pY5vfN_ywHaE6?rs=1&pid=ImgDetMain'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar item',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildCategoryList()
                : _buildProductList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    if (_categories.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        Category category = _categories[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListPage(categoryId: category.id),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                    image: DecorationImage(
                      image: NetworkImage(category.image_url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductList() {
    if (_filteredProducts.isEmpty) {
      return Center(child: Text('Nenhum produto'));
    }

    return ListView.builder(
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        Product product = _filteredProducts[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.description),
          trailing: Text('\$${product.price.toString()}'),
          leading: Image.network(
            product.image_url,
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
    );
  }
}
