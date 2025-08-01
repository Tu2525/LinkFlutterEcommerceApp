import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
    final IconData icon;
    final VoidCallback onPressed;
    const QuantityButton({super.key, required this.icon, required this.onPressed});

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20),
            child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16),
            ),
        );
    }
}