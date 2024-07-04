class Order {
  final List<OrderItem> items;
  final String payment_method;

  Order({
    required this.items,
    required this.payment_method,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'payment_method': payment_method,
    };
  }
}

class OrderItem {
  final int product_id;
  final int? additional_id;
  final int quantity;
  final double price;

  OrderItem({
    required this.product_id,
    this.additional_id,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'additional_id': additional_id,
      'quantity': quantity,
      'price': price,
    };
  }
}
