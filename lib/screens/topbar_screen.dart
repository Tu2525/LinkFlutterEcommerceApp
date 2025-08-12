import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/top_bar.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(child: Scaffold(body: TopBar(showHeartIcon: false,)));
  }
}
