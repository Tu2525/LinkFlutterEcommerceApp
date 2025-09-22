// lib/providers/home_page_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageNotifier extends ChangeNotifier {
  String _selectedCategory = '';
  List<String> _categories = [];

  String get selectedCategory => _selectedCategory;
  List<String> get categories => _categories;

  void initCategories({
    required String defaultCategory,
    required List<String> categories,
  }) {
    if (_categories.isEmpty) {
      _categories = categories;
      _selectedCategory = defaultCategory;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

final homePageProvider = ChangeNotifierProvider<HomePageNotifier>((ref) {
  return HomePageNotifier();
});
