import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/providers/main_screen_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/homepage_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/notification_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/orders_screen.dart';
import 'package:link_flutter_ecommerce_app/profile/screens/profile_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const NotificationScreen(),
    const OrdersScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainScreenController = ref.watch(mainScreenProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: IndexedStack(
        index: mainScreenController.selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardBackgroundColor(isDarkMode),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: AppColors.textSecondaryColor(isDarkMode),
        selectedItemColor: AppColors.primary,
        iconSize: 24,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.home_2),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.notification_bing),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.receipt_1),
            label: 'Receipt',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: mainScreenController.selectedIndex,
        onTap: (index) => ref.read(mainScreenProvider).setIndex(index),
      ),
    );
  }
}
