import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/services/product_service.dart';

class Search extends StatelessWidget {
  Search({super.key, required this.searchQuery});
  final String searchQuery;
  final ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productService.searchProductsStream(searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found for "$searchQuery"'));
        }
        final products = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                leading:
                    product.imageUrls?.isNotEmpty == true
                        ? Image.network(
                          product.imageUrls![0],
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                          width: 50,
                        )
                        : null,
              ),
            );
          },
        );
      },
    );
  }
}
