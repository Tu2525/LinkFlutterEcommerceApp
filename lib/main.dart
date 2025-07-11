import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/splash_screen.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Circular'),
      darkTheme: ThemeData(brightness: Brightness.dark, fontFamily: 'Circular'),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
