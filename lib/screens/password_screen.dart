import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/ask_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with WidgetsBindingObserver {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDarkMode(); // Call it here instead
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _updateDarkMode();
  }

  void _updateDarkMode() {
    setState(() {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });
  }

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 123),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(height: 32),
              CustomTextField(
                emailController: _passwordController,
                isPassword: true,
                hint: 'Password',
                isdark: isDarkMode,
              ),
              SizedBox(height: 16),
              ContinueButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              AskButton(
                isdark: isDarkMode,
                text: 'Forgot Password',
                button: 'Reset',
                onpressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
