import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations_ar.dart';
import 'package:link_flutter_ecommerce_app/providers/user_info_providers.dart';
import 'package:link_flutter_ecommerce_app/screens/onboarding_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/age_range_dropdown.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/gender_selection_row.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFormValid = ref.watch(isFormValidProvider);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1C1B20) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                AppLocalizations.of(context)!.tellUsAboutYourself,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.sp),
              ),
              SizedBox(height: 48.h),
              Text(
                AppLocalizations.of(context)!.whoDoYouShopFor,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              const GenderSelectionRow(),
              SizedBox(height: 40.h),
              Text(
                AppLocalizations.of(context)!.howoldAreYou,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              const AgeRangeDropdown(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: isDark ? const Color(0xFF342F3F) : const Color(0xffF4F4F4),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: ContinueButton(
          onPressed:
              isFormValid
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen(),
                      ),
                    );
                  }
                  : () {},
          text: AppLocalizations.of(context)!.finish,
        ),
      ),
    );
  }
}
