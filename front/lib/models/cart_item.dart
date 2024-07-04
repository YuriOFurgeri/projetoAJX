import 'package:front/models/product.dart';
import 'package:front/models/additional.dart';

class CartItem {
  final Product product;
  final Additional? additional;
  final int quantity;

  CartItem({
    required this.product,
    this.additional,
    required this.quantity,
  });
}
