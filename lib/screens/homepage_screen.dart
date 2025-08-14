import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/features/profile/screens/profile_screen.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/home_page_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/cart_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories_section.dart';
import 'package:link_flutter_ecommerce_app/widgets/top_selling_section.dart';
import 'package:link_flutter_ecommerce_app/providers/top_selling_products_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/new_in_products_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    Future(() {
      if (mounted) {
        ref
            .read(homePageProvider)
            .initCategories(
              defaultCategory: AppLocalizations.of(context)!.men,
              categories: [
                AppLocalizations.of(context)!.men,
                AppLocalizations.of(context)!.women,
                AppLocalizations.of(context)!.kids,
              ],
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = ref.watch(homePageProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: SafeArea(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/536/354',
                            ),
                          ),
                        ),
                        // Theme toggle button
                        // Category dropdown
                        PopupMenuButton<String>(
                          onSelected: (String result) {
                            ref.read(homePageProvider).selectCategory(result);
                          },
                          itemBuilder:
                              (BuildContext context) =>
                                  homeNotifier.categories.map((
                                    String category,
                                  ) {
                                    return PopupMenuItem<String>(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: AppColors.textPrimaryColor(
                                            isDarkMode,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceColor(isDarkMode),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColors.borderColor(isDarkMode),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  homeNotifier.selectedCategory,
                                  style: AppTextStyles.subTitle1(isDarkMode),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  IconsaxPlusBroken.arrow_down_2,
                                  size: 20,
                                  color: AppColors.textPrimaryColor(isDarkMode),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Shopping bag icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                            child: const Icon(
                              IconsaxPlusBroken.bag_2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceColor(isDarkMode),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.borderColor(isDarkMode),
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          color: AppColors.textPrimaryColor(isDarkMode),
                        ),
                        decoration: InputDecoration(
                          icon: Icon(
                            IconsaxPlusBroken.search_normal_1,
                            color: AppColors.textSecondaryColor(isDarkMode),
                          ),
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: TextStyle(
                            color: AppColors.textSecondaryColor(isDarkMode),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const CategoriesSection(),
                  const SizedBox(height: 24),
                  TopSellingSection(
                    provider: topSellingProductsProvider,
                    title: AppLocalizations.of(context)!.topSelling,
                  ),
                  const SizedBox(height: 24),
                  TopSellingSection(
                    title: AppLocalizations.of(context)!.newIn,
                    provider: newInProductsProvider,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
