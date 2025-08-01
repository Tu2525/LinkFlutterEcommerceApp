import 'package:flutter/material.dart';

@immutable
class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final String size;
  final String color;
  final double price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      imageUrl: imageUrl,
      size: size,
      color: color,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}