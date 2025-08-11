import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/category_section_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/products_of_category_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/CategoryCard.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final locale = Localizations.localeOf(context).languageCode;
    final categoriesAsync = ref.watch(categoryProvider(locale));

    return categoriesAsync.when(
      data: (categories) {
        return Scaffold(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomIcon(),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      AppLocalizations.of(context)!.shopByCategory,
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => ProductsOfCategoryScreen(
                                        categoryName: item.title,
                                      ),
                                ),
                              );
                            },
                            child: CategoryCard(
                              image: item.imgPath,
                              title: item.title,
                              isDarkMode: isDarkMode,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading:
          () => Scaffold(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            body: const Center(child: CircularProgressIndicator()),
          ),
      error:
          (error, stack) => Scaffold(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            body: Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
    );
  }
}
