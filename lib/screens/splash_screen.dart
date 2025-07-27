import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/splash_timer_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    var splashAnimation= ref.read(splashAnimationProvider);
    splashAnimation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8E6CEF),
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [WavyAnimatedText('Clot')],
          ),
        ),
      ),
    );
  }
}