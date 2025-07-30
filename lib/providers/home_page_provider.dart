// lib/providers/home_page_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageNotifier extends ChangeNotifier {
  String _selectedCategory = 'Men';
  final List<String> _categories = ['Men', 'Women', 'Kids'];

  String get selectedCategory => _selectedCategory;
  List<String> get categories => _categories;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

final homePageProvider = ChangeNotifierProvider<HomePageNotifier>((ref) {
  return HomePageNotifier();
});