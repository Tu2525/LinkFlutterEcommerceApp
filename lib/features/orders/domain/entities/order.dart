class Order {
  final String key;
  final List<OrderItem> items;
  final List<OrderStep> steps;
  final ShippingInfo shipping;
  final String status;
  final String userId;
  final DateTime createdAt;
  final double totalAmount;

  Order({
    required this.status,
    required this.key,
    required this.items,
    required this.steps,
    required this.shipping,
    required this.userId,
    required this.createdAt,
    required this.totalAmount,
  });
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;
  final String? productId;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
    this.productId,
  });
}

class OrderStep {
  final String title;
  final bool isChecked;
  final String date;

  OrderStep({required this.title, required this.isChecked, required this.date});
}

class ShippingInfo {
  final String address;

  ShippingInfo({required this.address});
}