import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/categories_list_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';

class WithoutDataWidget extends StatelessWidget {
  const WithoutDataWidget({super.key, required this.img, required this.text});
  final String img;
  final String text;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, width: 100),
          const SizedBox(height: 20),
          Text(
            text,
            style: AppTextStyles.heading4(isDarkMode),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesList()),
                );
              },
              text: AppLocalizations.of(context)!.exploreCategories,
            ),
          ),
        ],
      ),
    );
  }
}
