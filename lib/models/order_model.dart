
class OrderModel {
  final String id;
  final List<OrderItem> items;
  final List<OrderStep> steps;
  final ShippingInfo shipping;
  final String status;

  OrderModel({
    required this.status,
    required this.id,
    required this.items,
    required this.steps,
    required this.shipping,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'],
      id: json['id'],
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
      steps: (json['steps'] as List).map((e) => OrderStep.fromJson(e)).toList(),
      shipping: ShippingInfo.fromJson(json['shipping']),
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;

  OrderItem({required this.name, required this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(name: json['name'], quantity: json['quantity']);
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
}

class ShippingInfo {
  final String name;
  final String phone;
  final String address;

  ShippingInfo({
    required this.name,
    required this.phone,
    required this.address,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
