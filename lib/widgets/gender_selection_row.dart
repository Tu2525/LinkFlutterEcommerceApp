import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/user_info_providers.dart';
import 'package:link_flutter_ecommerce_app/widgets/gender_button.dart';

class GenderSelectionRow extends ConsumerWidget {
  const GenderSelectionRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(selectedGenderProvider);

    return Row(
      children: [
        Expanded(
          child: GenderButton(
            gender: AppLocalizations.of(context)!.men,
            isSelected: selectedGender == 'Men',
            onTap:
                () => ref.read(selectedGenderProvider.notifier).state = 'Men',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GenderButton(
            gender: AppLocalizations.of(context)!.women,
            isSelected: selectedGender == 'Women',
            onTap:
                () => ref.read(selectedGenderProvider.notifier).state = 'Women',
          ),
        ),
      ],
    );
  }
}
