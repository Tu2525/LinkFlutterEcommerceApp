import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TopBar extends StatelessWidget {
  final bool showHeartIcon;
  final VoidCallback? onHeartPressed;
  const TopBar({super.key, this.showHeartIcon = true, this.onHeartPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            icon: IconsaxPlusBroken.arrow_left_2,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (showHeartIcon)
            _buildIconButton(
              icon: IconsaxPlusBroken.heart,
              onPressed:
                  onHeartPressed ??
                  () {
                    // print("Heart icon pressed!");
                  },
            ),
        ],
      ),
    );
  }

  /// Builds a reusable icon button with a specific icon and action.
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            // CORRECTED: .withOpacity() is the correct method
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 20),
        // The action to perform when the button is tapped
        onPressed: onPressed,
      ),
    );
  }
}
