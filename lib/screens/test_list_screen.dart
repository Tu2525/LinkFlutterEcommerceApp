import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/horizontal_list.dart';
import 'package:link_flutter_ecommerce_app/utils/sample_data.dart';

class TestListScreen extends StatelessWidget {
  const TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              HorizontalList(
                title: 'Top Selling',
                products: SampleData.getTopSellingProducts(),
                onSeeAllTap: () {
                  print('Top Selling - See All tapped');
                },
                onProductTap: (product) {
                  print('Top Selling - Product tapped: ${product.name}');
                },
                onFavoriteToggle: (product) {
                  print('Top Selling - Favorite toggled: ${product.name}');
                },
              ),
              const SizedBox(height: 30),
              HorizontalList(
                title: 'New Arrivals',
                products: SampleData.getNewArrivals(),
                onSeeAllTap: () {
                  print('New Arrivals - See All tapped');
                },
                onProductTap: (product) {
                  print('New Arrivals - Product tapped: ${product.name}');
                },
                onFavoriteToggle: (product) {
                  print('New Arrivals - Favorite toggled: ${product.name}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
