import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/onboardingscreen_model.dart';
import 'package:link_flutter_ecommerce_app/screens/Main_screen.dart';

final List<OnBoardingScreenModel> screens = [
  OnBoardingScreenModel(
    icon: 'images/Purchase online.png',
    img: 'images/Onboard 1.png',
    subtitle: 'Shop smarter, faster, and easier',
    title: 'Purchase Online !!',
  ),
  OnBoardingScreenModel(
    icon: 'images/Track Order.png',
    img: 'images/Onboard 2 (2).png',
    subtitle: 'Fast. Transparent. Always on time',
    title: 'Track order !!',
  ),
  OnBoardingScreenModel(
    icon: 'images/Get your order.png',
    img: 'images/Onboard 3 (2).png',
    subtitle: 'Receive your order fast and hassle-free',
    title: 'Get your order !!',
  ),
];

final onboardingScreenProvider = Provider<List<OnBoardingScreenModel>>((ref) {
  return screens;
});

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, int>((ref) {
      return OnboardingController();
    });

class OnboardingController extends StateNotifier<int> {
  OnboardingController() : super(0);

  final PageController pageController = PageController();

  void updateIndexFromScroll() {
    final newIndex = pageController.page?.round() ?? 0;
    if (newIndex != state) {
      state = newIndex;
    }
  }

  void nextPage(BuildContext context) {
    if (state == 2) {
      goToHomeScreen(context);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

