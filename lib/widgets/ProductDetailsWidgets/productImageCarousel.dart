import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';

class ProductImageCarousel extends ConsumerWidget {
  final Product product;
  const ProductImageCarousel({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = this.product;
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: product.imageUrls?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                product.imageUrls![index],
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
              ),
            ),
          );
        },
      ),
    );
  }
}
