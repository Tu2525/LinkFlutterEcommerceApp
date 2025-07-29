import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/TopBar.dart';

class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TopBar(),
                    const _ProductImageCarousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8A2BE2),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const _SizeSelector(),
                          const SizedBox(height: 16),
                          const _ColorSelector(),
                          const SizedBox(height: 16),
                          const _QuantitySelector(),
                          const SizedBox(height: 24),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const _InfoSection(
                            title: 'Shipping & Returns',
                            content:
                                'Free standard shipping and free 60-day returns',
                          ),
                          const SizedBox(height: 24),
                          const _ReviewsSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned "Add to Bag" button at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: _AddToBagButton(totalPrice: totalPrice),
            ),
          ],
        ),
      ),
    );
  }
}
