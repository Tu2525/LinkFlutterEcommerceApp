import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardNumberProvider = StateProvider<String>((ref) => '');

final last4DigitsProvider = Provider<String>((ref) {
  final number = ref.watch(cardNumberProvider);

  return number.length >= 4 ? number.substring(number.length - 4) : '';
});
