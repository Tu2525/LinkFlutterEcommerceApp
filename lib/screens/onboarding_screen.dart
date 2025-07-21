import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/Main_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/onboarding_screen_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller =PageController();
  int _currentIndex = 0;

  final List<String> titles = [
    'Purchase Online !!', 
    'Track order !!',
    'Get your order !!'
    ];

  final List<String> subtitles = [
    'Shop smarter, faster, and easier',
    'Fast. Transparent. Always on time',
    'Receive your order fast and hassle-free',
  ];

  final List<String> images = [
    'images/Onboard 1.png',
    'images/Onboard 2 (2).png',
    'images/Onboard 3 (2).png',
  ];

  final List<String> icons = [
    'images/Purchase online.png',
    'images/Track Order.png',
    'images/Get your order.png',
  ];


  @override
void initState() {
  super.initState();
  _controller.addListener(() {
    setState(() {
      log("   log(_currentIndex), $_currentIndex");
      _currentIndex = _controller.page?.round() ?? 0;
    });
  });
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          children: [
            OnboardingScreenWidget(
            title: titles[0],
            subtitle1: subtitles[0],
            iconPath: icons[0],
            imagePath: images[0],
            index: 0,
          ),
            OnboardingScreenWidget(
            title: titles[1],
            subtitle1: subtitles[1],
            iconPath: icons[1],
            imagePath: images[1],
            index: 1,
            color:const Color(0XFF7803E6),
            color2: Colors.black,

          ),   
            OnboardingScreenWidget(
            title: titles[2],
            subtitle1: subtitles[2],
            iconPath: icons[2],
            imagePath: images[2],
            index: 2,
          ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding:const EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: ()=> Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const MainScreen(),
              ))
            , child: const Text('Skip')),
            Center(
              child: SmoothPageIndicator(
                controller: _controller, 
                count: 3,
                effect: const WormEffect(
                  spacing: 16,
                  activeDotColor: Colors.purple,
                ),
                onDotClicked: (index) => _controller.animateToPage(
                  index, 
                duration: const Duration(microseconds: 500)
                , curve: Curves.easeIn),),
            ),
            TextButton( 
              onPressed: () {
                if (_currentIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen {
  const HomeScreen();
}
