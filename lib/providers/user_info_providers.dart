import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGenderProvider = StateProvider<String?>((ref) => null);

final selectedAgeRangeProvider = StateProvider<String?>((ref) => null);

final isFormValidProvider = Provider<bool>((ref) {
  final gender = ref.watch(selectedGenderProvider);
  final age = ref.watch(selectedAgeRangeProvider);
  return gender != null && age != null;
});
