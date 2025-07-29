import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/providers/main_screen_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/homepage_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/notification_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    NotificationScreen(),
    ReceiptPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainScreenController = ref.watch(mainScreenProvider);
    return Scaffold(
      body: IndexedStack(
        index: mainScreenController.selectedIndex,
        children: _pages,
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: const Color.fromARGB(50, 39, 39, 39),
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
        currentIndex:  mainScreenController.selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => ref.read(mainScreenProvider).setIndex(index),
      ),
    );
  }
}

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Receipt Page', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Page', style: TextStyle(fontSize: 24)),
    );
  }
}
