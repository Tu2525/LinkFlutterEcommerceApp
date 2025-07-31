# Firebase Integration Fix Guide

## Current Issues:

1. Flutter packages are not being recognized by the IDE
2. Firebase packages cannot be imported
3. Basic Flutter imports are failing

## Solution Steps:

### Step 1: Fix Package Installation

Run these commands in your terminal:

```bash
cd "d:\flutter_interns\link\ecommerce_v2\LinkFlutterEcommerceApp"
flutter clean
flutter pub cache repair
flutter pub get
```

### Step 2: Verify Flutter Installation

```bash
flutter doctor -v
```

### Step 3: Restart VS Code

- Close VS Code completely
- Reopen the project
- Wait for Dart Analysis to complete

### Step 4: Once packages are working, update main.dart:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:link_flutter_ecommerce_app/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: EcommerceApp()));
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Circular',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Circular',
        ),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
```

### Step 5: Files Already Created for Firebase Integration:

- ✅ `lib/services/auth_service.dart` - Firebase Authentication service
- ✅ `lib/services/firestore_service.dart` - Firestore database service
- ✅ `lib/models/product_model.dart` - Product model for Firestore
- ✅ `lib/providers/app_providers.dart` - Riverpod providers
- ✅ `lib/widgets/auth_wrapper.dart` - Authentication wrapper widget
- ✅ `lib/screens/login_screen.dart` - Login screen for testing

### Step 6: Next Steps After Fixing Package Issues:

1. Test the app builds and runs: `flutter run`
2. Test Firebase authentication with the login screen
3. Set up Firestore security rules in Firebase Console
4. Add sample data to test database operations
5. Integrate Firebase services into your existing screens

### Common Issues:

- **"Target of URI doesn't exist"**: Packages not installed
- **"Undefined class"**: Missing imports or packages not installed
- **Firebase not initialized**: Need to call Firebase.initializeApp()

### Firebase Console Setup Required:

1. Enable Authentication (Email/Password)
2. Create Firestore Database
3. Set up security rules
4. Enable Analytics (optional)
