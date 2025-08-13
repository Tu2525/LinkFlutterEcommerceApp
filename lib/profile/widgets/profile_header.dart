import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/profile/models/user_model.dart';
import 'package:link_flutter_ecommerce_app/profile/providers/user_provider.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userAsyncValue = ref.watch(userProvider);
    // final authStateAsyncValue = ref.watch(authStateProvider);
    final userDocAsyncValue = ref.watch(userDocumentProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderColor(isDarkMode),
          width: 1,
        ),
      ),
      child: userDocAsyncValue.when(
        data: (userModel) {
          final fullName = '${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}'.trim();
          return _buildProfileContent(
            context,
            isDarkMode: isDarkMode,
            name: userModel != null && fullName.isNotEmpty ? fullName : 'Guest User',
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
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, {
    required bool isDarkMode,
    required String name,
    required String email,
  }) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primary,
          child: Icon(
            IconsaxPlusBroken.profile,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.heading3(isDarkMode),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: AppTextStyles.body2(isDarkMode),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
