import '../models/product.dart';

class SampleData {
  static List<Product> getTopSellingProducts() {
    return [
      Product(
        id: '1',
        name: 'Men\'s Harrington Jacket',
        price: 148.00,
        originalPrice: 180.00,
        imageUrl:
            'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        isFavorite: false,
        category: 'Clothing',
        rating: 4.5,
        reviewCount: 24,
      ),
      Product(
        id: '2',
        name: 'Max Cirro Men\'s Slides',
        price: 55.00,
        originalPrice: 100.97,
        imageUrl:
            'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        isFavorite: true,
        category: 'Footwear',
        rating: 4.2,
        reviewCount: 156,
      ),
      Product(
        id: '3',
        name: 'Men\'s Casual Shirt',
        price: 89.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Shirt',
        isFavorite: false,
        category: 'Clothing',
        rating: 4.7,
        reviewCount: 89,
      ),
      Product(
        id: '4',
        name: 'Premium Sneakers',
        price: 120.00,
        originalPrice: 150.00,
        imageUrl: 'https://via.placeholder.com/200x200?text=Sneakers',
        isFavorite: false,
        category: 'Footwear',
        rating: 4.3,
        reviewCount: 67,
      ),
      Product(
        id: '5',
        name: 'Leather Wallet',
        price: 45.00,
        imageUrl: 'https://via.placeholder.com/200x200?text=Wallet',
        isFavorite: true,
        category: 'Accessories',
        rating: 4.8,
        reviewCount: 203,
      ),
    ];
  }

  static List<Product> getNewArrivals() {
    return [
      Product(
        id: '6',
        name: 'Wireless Headphones',
        price: 199.99,
        originalPrice: 249.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Headphones',
        isFavorite: false,
        category: 'Electronics',
        rating: 4.6,
        reviewCount: 89,
      ),
      Product(
        id: '7',
        name: 'Running Shoes',
        price: 129.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Running+Shoes',
        isFavorite: true,
        category: 'Footwear',
        rating: 4.8,
        reviewCount: 156,
      ),
      Product(
        id: '8',
        name: 'Denim Jacket',
        price: 89.99,
        originalPrice: 120.00,
        imageUrl: 'https://via.placeholder.com/200x200?text=Denim+Jacket',
        isFavorite: false,
        category: 'Clothing',
        rating: 4.4,
        reviewCount: 67,
      ),
    ];
  }

  static List<Product> getFeaturedProducts() {
    return [
      Product(
        id: '9',
        name: 'Smart Watch',
        price: 299.99,
        originalPrice: 399.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Smart+Watch',
        isFavorite: false,
        category: 'Electronics',
        rating: 4.7,
        reviewCount: 234,
      ),
      Product(
        id: '10',
        name: 'Backpack',
        price: 79.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Backpack',
        isFavorite: true,
        category: 'Accessories',
        rating: 4.5,
        reviewCount: 123,
      ),
      Product(
        id: '11',
        name: 'Sunglasses',
        price: 149.99,
        originalPrice: 199.99,
        imageUrl: 'https://via.placeholder.com/200x200?text=Sunglasses',
        isFavorite: false,
        category: 'Accessories',
        rating: 4.3,
        reviewCount: 78,
      ),
    ];
  }
}
