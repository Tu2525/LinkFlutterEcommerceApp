import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Men';
  final List<String> _categories = ['Men', 'Women', 'Kids'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          children: [
            Row(
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
                    setState(() {
                      _selectedCategory = result;
                    });
                  },
                  itemBuilder:
                      (BuildContext context) =>
                          _categories.map((String category) {
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
                          _selectedCategory,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        const Icon(IconsaxPlusBroken.arrow_down_2, size: 20),
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

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(IconsaxPlusBroken.search_normal_1),
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Expanded(
              child: Center(child: Text('7oto el 7agat el taniya')),
            ),
          ],
        ),
      ),
    );
  }
}
