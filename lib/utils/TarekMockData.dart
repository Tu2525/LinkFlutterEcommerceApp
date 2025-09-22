import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/models/review.dart';

final Product mockProduct = Product(
  id: 'nike-harrington-123',
  name: "Men's Harrington Jacket",
  price: 148.00,
  originalPrice: 170.00,
  description:
      "Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.",
  imageUrls: ["https://placehold.co/600x800/a3b18a/ffffff?text=Jacket+1"],
  category: "Jackets",
  rating: 4.5,
  reviewCount: 2,
  reviews: [
    Review(
      author: "Alex Morgan",
      avatarUrl: "https://placehold.co/100x100/f2e8cf/344e41?text=AM",
      rating: 4.0,
      comment:
          "Gucci transcribes its heritage, creativity, and innovation into a plenitude of collections. From staple items to distinctive accessories.",
      date: "12 days ago",
    ),
    Review(
      author: "Jane Doe",
      avatarUrl: "https://placehold.co/100x100/dad7cd/344e41?text=JD",
      rating: 5.0,
      comment: "Absolutely love this jacket! The quality is amazing and it fits perfectly. Highly recommended.",
      date: "15 days ago",
    ),
  ],
);