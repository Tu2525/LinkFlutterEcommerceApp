import '../../domain/entities/order.dart' as entity;

class OrderModel extends entity.Order {
  OrderModel({
    required super.status,
    required super.key,
    required super.items,
    required super.steps,
    required super.shipping,
    required super.userId,
    required super.createdAt,
    required super.totalAmount,
  });

  factory OrderModel.fromFireStore(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'] ?? 'pending',
      key: json['key'] ?? '',
      items: (json['items'] as List? ?? []).map((e) => OrderItemModel.fromJson(e)).toList(),
      steps: (json['steps'] as List? ?? []).map((e) => OrderStepModel.fromJson(e)).toList(),
      shipping: ShippingInfoModel.fromJson(json['shipping'] ?? {}),
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['createdAt']) : DateTime.now(),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'items': (items as List<OrderItemModel>).map((item) => item.toJson()).toList(),
      'steps': (steps as List<OrderStepModel>).map((step) => step.toJson()).toList(),
      'shipping': (shipping as ShippingInfoModel).toJson(),
      'status': status,
      'userId': userId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'totalAmount': totalAmount,
    };
  }
}

class OrderItemModel extends entity.OrderItem {
  OrderItemModel({
    required super.name,
    required super.quantity,
    required super.price,
    super.imageUrl,
    super.productId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
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
}

class OrderStepModel extends entity.OrderStep {
  OrderStepModel({required super.title, required super.isChecked, required super.date});

  factory OrderStepModel.fromJson(Map<String, dynamic> json) {
    return OrderStepModel(
      title: json['title'],
      isChecked: json['isChecked'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isChecked': isChecked, 'date': date};
  }
}

class ShippingInfoModel extends entity.ShippingInfo {
  ShippingInfoModel({required super.address});

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) {
    return ShippingInfoModel(address: json['address'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'address': address};
  }
}