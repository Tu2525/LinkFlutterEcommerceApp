class Product {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final String? imageUrl;
  final bool isFavorite;
  final String? category;
  final double? rating;
  final int? reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.isFavorite = false,
    this.category,
    this.rating,
    this.reviewCount,
  });

  // Factory constructor for creating Product from JSON (for API integration)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['original_price']?.toDouble(),
      imageUrl: json['image_url'],
      isFavorite: json['is_favorite'] ?? false,
      category: json['category'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
    );
  }

  // Convert Product to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
      'category': category,
      'rating': rating,
      'review_count': reviewCount,
    };
  }

  // Helper method to check if product is on sale
  bool get isOnSale => originalPrice != null && originalPrice! > price;

  // Helper method to calculate discount percentage
  double get discountPercentage {
    if (!isOnSale) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  // Create a copy with updated properties
  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? originalPrice,
    String? imageUrl,
    bool? isFavorite,
    String? category,
    double? rating,
    int? reviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}
