import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/providers/favourites_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  Stream<List<Product>> _fetchProducts(List<String> ids) {
    if (ids.isEmpty) return Stream.value([]);
    return FirebaseFirestore.instance
        .collection('products')
        .where(FieldPath.documentId, whereIn: ids)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                data['id'] = doc.id;
                return Product.fromJson(data);
              }).toList(),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body:
          favorites.isEmpty
              ? const Center(child: Text("No favorites yet."))
              : StreamBuilder<List<Product>>(
                stream: _fetchProducts(favorites),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return const Center(child: Text("No favorites yet."));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product.copyWith(
                          isFavorite: favorites.contains(product.id),
                        ),
                        onFavoriteToggle: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(product.id);
                        },
                      );
                    },
                  );
                },
              ),
    );
  }
}
