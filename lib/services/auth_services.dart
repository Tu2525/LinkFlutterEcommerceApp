import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_provider.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required WidgetRef ref,
    required String email,
    required String password,
    required String name,
  }) async {
    ref.read(authLoadingProvider.notifier).state = true;
    ref.read(authErrorProvider.notifier).state = '';
    ref.read(authSuccessProvider.notifier).state = false;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      final userDoc = firestore.collection('users').doc(uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.emailIsAlreadyInUse;
      } else {
        await userDoc.set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        ref.read(authSuccessProvider.notifier).state = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.emailIsAlreadyInUse;
      } else if (e.code == 'invalid-email') {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.invalidEmail;
      } else if (e.code == 'weak-password') {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.weakPassword;
      } else {
        ref.read(authErrorProvider.notifier).state =
            e.message ?? AppLocalizations.of(ref.context)!.authError;
      }
    } catch (e) {
      ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> loginUser({
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    ref.read(authLoadingProvider.notifier).state = true;
    ref.read(authErrorProvider.notifier).state = '';
    ref.read(authSuccessProvider.notifier).state = false;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      ref.read(authSuccessProvider.notifier).state = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'No account found for this email') {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.noUserFound;
      } else if (e.code == 'invalid-credential') {
        ref.read(authErrorProvider.notifier).state =
            AppLocalizations.of(ref.context)!.wrongPassword;
      } else {
        ref.read(authErrorProvider.notifier).state =
            e.message ?? AppLocalizations.of(ref.context)!.authError;
      }
    } catch (e) {
      ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    final snapshot =
        await firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
    return snapshot.docs.isNotEmpty;
  }
}
