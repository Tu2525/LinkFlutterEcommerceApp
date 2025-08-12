import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en'));

  void switchToEnglish() {
    state = const Locale('en');
  }

  void switchToArabic() {
    state = const Locale('ar');
  }

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      switchToArabic();
    } else {
      switchToEnglish();
    }
  }
}
