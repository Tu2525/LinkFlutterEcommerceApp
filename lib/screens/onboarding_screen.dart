import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/onboarding_screen_providor.dart';
import 'package:link_flutter_ecommerce_app/widgets/onboarding_screen_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    final controller = ref.read(onboardingControllerProvider.notifier);
    controller.pageController.addListener(() {
      controller.updateIndexFromScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(onboardingControllerProvider.notifier);
    final pageController = controller.pageController;
    final screens = ref.watch(onboardingScreenProvider(context));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          children: List.generate(
            screens.length,
            (index) => OnboardingScreenWidget(
              title: screens[index].title,
              subtitle1: screens[index].subtitle,
              iconPath: screens[index].icon,
              imagePath: screens[index].img,
              index: index,
              color: index == 1 ? AppColors.primary : null,
              color2: index == 1 ? AppColors.darkBackground : null,
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.goToHomeScreen(context),
              child: Text(AppLocalizations.of(context)!.skip),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: screens.length,
                effect: const WormEffect(
                  spacing: 16,
                  activeDotColor: AppColors.primary,
                ),
                onDotClicked:
                    (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(context),
              child: Text(AppLocalizations.of(context)!.next),
            ),
          ],
        ),
      ),
    );
  }
}
