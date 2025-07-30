import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';
import '../providers/products_of_category_provider.dart';
import '../constants/app_colors.dart';

class ProductsOfCategoryScreen extends ConsumerWidget {
  final String categoryName;
  const ProductsOfCategoryScreen({Key? key, required this.categoryName})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsOfCategoryProvider(categoryName));
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.centerLeft,
                child: Material(
                  color:
                      isDarkMode
                          ? const Color(0xFF342F3F)
                          : const Color(0xFFF4F4F4),
                  shape: const CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        IconsaxPlusBroken.arrow_left_2,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '${categoryName} (${productsState.length})',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  childAspectRatio: 161 / 281,
                ),
                itemCount: productsState.length,
                itemBuilder: (context, index) {
                  final product = productsState[index];
                  return ProductCard(
                    product: product,
                    cardColor:
                        isDarkMode
                            ? const Color(0xFF342F3F)
                            : (AppColors.grey ?? Colors.grey[200]!),
                    width: 161,
                    height: 281,
                    onTap: () {},
                    onFavoriteToggle: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
