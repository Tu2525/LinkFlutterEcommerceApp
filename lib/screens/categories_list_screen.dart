import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/CategoryCard.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final categories = [
      {
        "image": "images/8d40b2ff9a729542c316774eec94b994b83da2b9.png",
        "category": "Hoodies",
      },
      {
        "image": "images/ad54c3d508e579e5faa2fa7794697833726d84ee.png",
        "category": "Accessories",
      },
      {
        "image": "images/0f7013a04882ff37a8f9dfb7288a70dd163aa02d.png",
        "category": "Shorts",
      },
      {
        "image": "images/0a570874d5e4811d45067854f7bf8387ed202685.png",
        "category": "Shoes",
      },
      {
        "image": "images/6a96d4db645c59111253564fb0994b3b2da4b022.jpg",
        "category": "Bags",
      },
    ];

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
                  'Shop by Categories',
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
                      child: CategoryCard(
                        image: item["image"]!,
                        title: item["category"]!,
                        isDarkMode: isDarkMode,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
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
  }
}
