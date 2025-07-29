import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/providers/home_page_provider.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories_section.dart';
import 'package:link_flutter_ecommerce_app/widgets/top_selling_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.watch(homePageProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/536/354',
                        ),
                      ),

                      PopupMenuButton<String>(
                        onSelected: (String result) {
                          ref.read(homePageProvider).selectedCategory;
                        },
                        itemBuilder:
                            (BuildContext context) =>
                                homeNotifier.categories.map((String category) {
                                  return PopupMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Text(
                                homeNotifier.selectedCategory,
                                style: AppTextStyles.sectionTitle(isDarkMode),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                IconsaxPlusBroken.arrow_down_2,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          IconsaxPlusBroken.bag_2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                //Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(IconsaxPlusBroken.search_normal_1),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const CategoriesSection(),
                const SizedBox(height: 24),
                TopSellingSection(
                  products: MockProductData.getFeaturedProducts(),
                ),
                const SizedBox(height: 24),
                TopSellingSection(
                  title: "New in",
                  products: MockProductData.getFeaturedProducts(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
