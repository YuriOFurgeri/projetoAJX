class Order {
  final List<OrderItem> items;
  final String paymentMethod;

  Order({
    required this.items,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'payment_method': paymentMethod,
    };
  }
}

class OrderItem {
  final int productId;
  final int? additionalId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    this.additionalId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'additional_id': additionalId,
      'quantity': quantity,
      'price': price,
    };
  }
}
