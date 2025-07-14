import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/sign_in_screen.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/2a7988bf70f4548361b00378b3d52898cf023ae2.png',
                    height: screenWidth * 0.25,
                    width: screenWidth * 0.25,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We Sent you an Email to reset',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                    ),
                  ),
                  const Text(
                    'your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8E6CEF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Return to Login',
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
