import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';

class OrderModel {
  final String key;
  final List<OrderItem> items;
  final List<OrderStep> steps;
  final ShippingInfo shipping;
  final String status;
  final String userId;
  final DateTime createdAt;
  final double totalAmount;

  OrderModel({
    required this.status,
    required this.key,
    required this.items,
    required this.steps,
    required this.shipping,
    required this.userId,
    required this.createdAt,
    required this.totalAmount,
  });

  factory OrderModel.fromFireStore(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'] ?? 'pending',
      key: json['key'] ?? '',
      items:
          (json['items'] as List? ?? [])
              .map((e) => OrderItem.fromJson(e))
              .toList(),
      steps:
          (json['steps'] as List? ?? [])
              .map((e) => OrderStep.fromJson(e))
              .toList(),
      shipping: ShippingInfo.fromJson(json['shipping'] ?? {}),
      userId: json['userId'] ?? '',
      createdAt:
          json['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
              : DateTime.now(),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'items': items.map((item) => item.toJson()).toList(),
      'steps': steps.map((step) => step.toJson()).toList(),
      'shipping': shipping.toJson(),
      'status': status,
      'userId': userId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'totalAmount': totalAmount,
    };
  }
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

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'productId': productId,
    };
  }

  static OrderItem fromCartItem(CartItem item) {
    return OrderItem(
      name: item.name,
      quantity: item.quantity,
      price: item.price,
      imageUrl: item.imageUrl,
      productId: item.id,
    );
  }
}

class OrderStep {
  final String title;
  final bool isChecked;
  final String date;

  OrderStep({required this.title, required this.isChecked, required this.date});

  factory OrderStep.fromJson(Map<String, dynamic> json) {
    return OrderStep(
      title: json['title'],
      isChecked: json['isChecked'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isChecked': isChecked, 'date': date};
  }
}

class ShippingInfo {
  final String address;

  ShippingInfo({required this.address});

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(address: json['address'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'address': address};
  }
}
