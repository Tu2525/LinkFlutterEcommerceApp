import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/features/profile/models/user_model.dart';

class CreateAccountManager extends ChangeNotifier {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();

  //Getters

  String get firstname => firstnameController.text;
  String get lastname => lastnameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;

  void submit() {
    final user = UserModel(
      firstName: firstname,
      lastName: lastname,
      email: email,
      password: password,
    );
    final userJson = user.toJson();
    final jsonString = jsonEncode(userJson);
    print('--- User Object as JSON Map ---');
    print(userJson);
    print('\n--- User Object as JSON String ---');
    print(jsonString);
  }

  @override
  void dispose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

final createAccountProvider =
    ChangeNotifierProvider.autoDispose<CreateAccountManager>((ref) {
      return CreateAccountManager();
    });
