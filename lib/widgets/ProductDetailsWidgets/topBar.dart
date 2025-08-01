import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TopBar extends StatelessWidget {
  final bool showHeartIcon;
  const TopBar({super.key, this.showHeartIcon = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(IconsaxPlusBroken.arrow_left_2),
          if(showHeartIcon) _buildIconButton(IconsaxPlusBroken.heart),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 20),
        onPressed: () {},
      ),
    );
  }
}
