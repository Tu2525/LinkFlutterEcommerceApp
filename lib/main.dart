import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: EcommerceApp()));
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light, fontFamily: 'Circular'),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Circular',
        ),
        themeMode: ThemeMode.system,
        home:  const SplashScreen(),
      ),
    );
  }
}
