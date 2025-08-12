import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/category_section_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/categories_list_screen.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categories,
                      style: AppTextStyles.subTitle1(isDarkMode),
                    ),
                    const Spacer(flex: 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriesList(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.seeAll,
                        style: AppTextStyles.seeAll(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final locale = Localizations.localeOf(context).languageCode;
                  final categoriesAsync = ref.watch(categoryProvider(locale));

                  return categoriesAsync.when(
                    data: (categories) => Row(children: categories),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
