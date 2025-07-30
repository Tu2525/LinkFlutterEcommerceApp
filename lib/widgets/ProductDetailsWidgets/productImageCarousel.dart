import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';

class ProductImageCarousel extends ConsumerWidget {
  const ProductImageCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);
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
                errorBuilder: (context, error, stackTrace) => 
                  const Center(child: Icon(Icons.error)),
              ),
            ),
          );
        },
      ),
    );
  }
}