import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class CouponCodeInput extends StatelessWidget {
  const CouponCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.enterCouponCode,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          IconsaxPlusBroken.discount_shape,
          color: Colors.black54,
        ),
        suffixIcon: IconButton(
          icon: const Icon(
            IconsaxPlusBroken.arrow_right_3,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
