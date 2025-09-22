import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/services/auth_services.dart';

final authLoadingProvider = StateProvider<bool>((ref) => false);

final authErrorProvider = StateProvider<String>((ref) => '');

final authSuccessProvider = StateProvider<bool>((ref) => false);

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
