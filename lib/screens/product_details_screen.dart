import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/addToBagButton.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/top_bar.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/colorSelector.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/infoSection.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/productImageCarousel.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/quantitySelector.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/reviewSection.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/sizeSelector.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [productProvider.overrideWithValue(product)],
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends ConsumerWidget {
  const _ProductDetailsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                    const TopBar(),
                    ProductImageCarousel(product: product),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            product.name,
                            style: AppTextStyles.heading3(isDarkMode),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.price,
                          ),
                          const SizedBox(height: 24),
                          const SizeSelector(),
                          const SizedBox(height: 16),
                          const ColorSelector(),
                          const SizedBox(height: 16),
                          const QuantitySelector(),
                          const SizedBox(height: 24),
                          // Text(
                          //   product.description as String,
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     color: Colors.grey[700],
                          //     height: 1.5,
                          //   ),
                          // ),
                          const SizedBox(height: 24),
                          InfoSection(
                            title:
                                AppLocalizations.of(context)!.shippingAndReturn,
                            content:
                                AppLocalizations.of(
                                  context,
                                )!.freeStandardShippingAndFreereturn,
                          ),
                          const SizedBox(height: 24),
                          const ReviewsSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AddToBagButton(totalPrice: totalPrice),
            ),
          ],
        ),
      ),
    );
  }
}
