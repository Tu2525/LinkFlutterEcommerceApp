import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/features/profile/providers/user_provider.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDocAsyncValue = ref.watch(userDocumentProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return userDocAsyncValue.when(
      data: (userModel) {
        final fullName = userModel?.firstName ?? "";
        return _buildProfileContent(
          context,
          isDarkMode: isDarkMode,
          name:
              userModel != null && fullName.isNotEmpty
                  ? fullName
                  : 'Guest User',
          email: userModel?.email ?? 'Not logged in',
        );
      },
      loading: () {
        return _buildProfileContent(
          context,
          isDarkMode: isDarkMode,
          name: 'Loading...',
          email: '...',
        );
      },
      error: (error, stackTrace) {
        return _buildProfileContent(
          context,
          isDarkMode: isDarkMode,
          name: 'Error',
          email: 'Could not load user data.',
        );
      },
    );
  }

  Widget _buildProfileContent(
    BuildContext context, {
    required bool isDarkMode,
    required String name,
    required String email,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
      color:isDarkMode? const Color(0xff342F3F): const Color.fromARGB(255, 234, 234, 232),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
        child: ListTile(
          title:  Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(email),
          // trailing: TextButton(
          //   onPressed: () {},
          //   child:  Text(AppLocalizations.of(context)!.edit, style: TextStyle(color: Colors.purple)),
          // ),
        ),
      ),
    );
  }
}
