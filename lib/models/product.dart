import 'dart:developer';

import 'package:link_flutter_ecommerce_app/models/review.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final List<String>? imageUrls;
  final bool isFavorite;
  final String? category;
  final double rating;
  final List<Review> reviews;
  final int? reviewCount;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    this.imageUrls,
    this.isFavorite = false,
    this.category,
    required this.rating,
    required this.reviews,
    this.reviewCount,
    required this.description,
  });

  // Factory constructor for creating Product from JSON (for API integration)
  factory Product.fromJson(Map<String, dynamic> json) {
    List<Review>? reviewsList;
    // Check if 'reviews' exists and is a list, then parse each item
    if (json['reviews'] != null && json['reviews'] is List) {
      reviewsList =
          (json['reviews'] as List)
              .map((reviewJson) => Review.fromJson(reviewJson))
              .cast<Review>()
              .toList();
    }

    List<String> images = []; //check the comment below.
    if (json['imageUrls'] != null && json['imageUrls'] is List) {
      //Shouldn't this be image_url? i am lost
      images = List<String>.from(json['imageUrls']);
      log(images.toString());
    }
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      imageUrls: images, //shouldn't this be images? -Tarek imageUrl: images
      isFavorite: json['is_favorite'] ?? false,
      category: json['category'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      reviews: reviewsList ?? [Review(author: "BUG", avatarUrl: "BUGBUG", rating: 10, comment: "BUGBUG", date: "27/27/27")],
      description: json['description']?.toString() ?? '',
    );
  }

  // Convert Product to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrls,
      'is_favorite': isFavorite,
      'category': category,
      'rating': rating,
      'review_count': reviewCount,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'description': description,
    };
  }

  // Helper method to check if product is on sale
  bool get isOnSale => originalPrice != null && originalPrice! > price;

  // Helper method to calculate discount percentage
  double get discountPercentage {
    if (!isOnSale) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    List<String>? imageUrls,
    bool? isFavorite,
    String? category,
    double? rating,
    int? reviewCount,
    List<Review>? reviews,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrls: imageUrls ?? this.imageUrls,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      reviews: reviews ?? this.reviews,
      description: description ?? this.description,
    );
  }
}
