import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/user_info_providers.dart';

class AgeRangeDropdown extends ConsumerWidget {
  const AgeRangeDropdown({super.key});

  static const List<String> ageRanges = [
    '0 - 5',
    '6 - 12',
    '13 - 17',
    '18 - 24',
    '25 - 34',
    '35 - 44',
    '45+',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedAgeRange = ref.watch(selectedAgeRangeProvider);
    final color = isDark ? const Color(0xFF342F3F) : const Color(0xffF4F4F4);

    return DropdownButtonFormField<String>(
      value: selectedAgeRange,
      decoration: InputDecoration(
        fillColor: color,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: color),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      hint: const Text('Select Age Range'),
      items:
          ageRanges.map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: (value) {
        ref.read(selectedAgeRangeProvider.notifier).state = value;
      },
    );
  }
}
