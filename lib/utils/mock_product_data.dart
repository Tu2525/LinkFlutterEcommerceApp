import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/models/review.dart';

import '../models/product.dart';



final placeHolderReview = Review( //WILL BE REMOVED
  author: "Tarek",
  avatarUrl: "https://placehold.co/100x100/344e41/f2e8cf?text=TS",
  rating: 4.5,
  comment: "This is a great product! I would definitely recommend it to a friend. The quality is top-notch and it exceeded my expectations.",
  date: "2 days ago",
);

final List<CartItem>placeHolderOrders = [
  const CartItem(
    id: '1',
    name: "Men's Harrington Jacket",
    imageUrl: 'https://placehold.co/100x100/A4E3A9/000000?text=Jacket',
    size: 'M',
    color: 'Lemon',
    price: 148.00,
  ),
  const CartItem(
    id: '2',
    name: "Men's Coaches Jacket",
    imageUrl: 'https://placehold.co/100x100/3D4C53/FFFFFF?text=Jacket',
    size: 'M',
    color: 'Black',
    price: 52.00,
  ),
];

final List<OrderModel> mockOrders = [
  OrderModel(
    id: "ORD-2025-08-01-001",
    status: "Shipped",
    items: [
      OrderItem(name: "Laptop Pro 15-inch", quantity: 1),
      OrderItem(name: "Wireless Mouse", quantity: 1),
      OrderItem(name: "USB-C Hub", quantity: 2),
    ],
    steps: [
      OrderStep(title: "Order Placed", isChecked: true, date: "2025-07-29"),
      OrderStep(title: "Processing", isChecked: true, date: "2025-07-30"),
      OrderStep(title: "Shipped", isChecked: true, date: "2025-08-01"),
      OrderStep(title: "Delivered", isChecked: false, date: ""),
    ],
    shipping: ShippingInfo(
      name: "John Doe",
      phone: "+1-202-555-0147",
      address: "123 Tech Avenue, Silicon Valley, CA 94043, USA",
    ), userId: '1',
  ),
  OrderModel(
    id: "ORD-2025-07-25-002",
    status: "Delivered",
    items: [
      OrderItem(name: "Smart Coffee Mug", quantity: 1),
      OrderItem(name: "Book: 'The Art of Code'", quantity: 1),
    ],
    steps: [
      OrderStep(title: "Order Placed", isChecked: true, date: "2025-07-25"),
      OrderStep(title: "Processing", isChecked: true, date: "2025-07-25"),
      OrderStep(title: "Shipped", isChecked: true, date: "2025-07-26"),
      OrderStep(title: "Delivered", isChecked: true, date: "2025-07-28"),
    ],
    shipping: ShippingInfo(
      name: "Jane Smith",
      phone: "+44 20 7946 0958",
      address: "456 Innovation Drive, London, E1 6AN, UK",
    ), userId: '2',
  ),
];

class MockProductData {
  static List<Product> getTopSellingProducts() {
    return [
      Product(
        id: '1',
        name: 'Men\'s Harrington Jacket',
        price: 148.00,
        originalPrice: 180.00,
        imageUrls: [
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ],
        isFavorite: false,
        category: 'Clothing',
        rating: 4.5,
        reviewCount: 24,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '2',
        name: 'Max Cirro Men\'s Slides',
        price: 55.00,
        originalPrice: 100.97,
        imageUrls: [
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=720&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ],
        isFavorite: true,
        category: 'Footwear',
        rating: 4.2,
        reviewCount: 156,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '3',
        name: 'Men\'s Casual Shirt',
        price: 89.99,
        imageUrls: ['https://via.placeholder.com/200x200?text=Shirt'],
        isFavorite: false,
        category: 'Clothing',
        rating: 4.7,
        reviewCount: 89,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '4',
        name: 'Premium Sneakers',
        price: 120.00,
        originalPrice: 150.00,
        imageUrls: ['https://via.placeholder.com/200x200?text=Sneakers'],
        isFavorite: false,
        category: 'Footwear',
        rating: 4.3,
        reviewCount: 67,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '5',
        name: 'Leather Wallet',
        price: 45.00,
        imageUrls: ['https://via.placeholder.com/200x200?text=Wallet'],
        isFavorite: true,
        category: 'Accessories',
        rating: 4.8,
        reviewCount: 203,
        reviews: [placeHolderReview], description: 'EMPTY'
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
        imageUrls: ['https://via.placeholder.com/200x200?text=Headphones'],
        isFavorite: false,
        category: 'Electronics',
        rating: 4.6,
        reviewCount: 89,
        reviews: [placeHolderReview],
        description: 'EMPTY'
      ),
      Product(
        id: '7',
        name: 'Running Shoes',
        price: 129.99,
        imageUrls: ['https://via.placeholder.com/200x200?text=Running+Shoes'],
        isFavorite: true,
        category: 'Footwear',
        rating: 4.8,
        reviewCount: 156,
        reviews: [placeHolderReview], description: ''
      ),
      Product(
        id: '8',
        name: 'Denim Jacket',
        price: 89.99,
        originalPrice: 120.00,
        imageUrls: ['https://via.placeholder.com/200x200?text=Denim+Jacket'],
        isFavorite: false,
        category: 'Clothing',
        rating: 4.4,
        reviewCount: 67,
        reviews: [placeHolderReview], description: 'EMPTY'
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
        imageUrls: ['https://via.placeholder.com/200x200?text=Smart+Watch'],
        isFavorite: false,
        category: 'Electronics',
        rating: 4.7,
        reviewCount: 234,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '10',
        name: 'Backpack',
        price: 79.99,
        imageUrls: ['https://via.placeholder.com/200x200?text=Backpack'],
        isFavorite: true,
        category: 'Accessories',
        rating: 4.5,
        reviewCount: 123,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
      Product(
        id: '11',
        name: 'Sunglasses',
        price: 149.99,
        originalPrice: 199.99,
        imageUrls: ['https://via.placeholder.com/200x200?text=Sunglasses'],
        isFavorite: false,
        category: 'Accessories',
        rating: 4.3,
        reviewCount: 78,
        reviews: [placeHolderReview], description: 'EMPTY'
      ),
    ];
  }
}
