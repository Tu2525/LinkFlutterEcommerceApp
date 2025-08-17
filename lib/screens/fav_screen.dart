import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/providers/favourites_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.favorites)),
      body:
          favorites.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noFavorites))
              : StreamBuilder<List<Product>>(
                stream: fetchProducts(favorites),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  final products = snapshot.data ?? [];
                  if (products.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context)!.noFavorites),
                    );
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
                      log(product.imageUrls.toString());
                      return ProductCard(
                        product: product.copyWith(
                          isFavorite: favorites.contains(product.id),
                          imageUrls: product.imageUrls,
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
