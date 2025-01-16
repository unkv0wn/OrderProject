import 'package:flutter/material.dart';
import 'package:orderview/src/utils/colors/colors.dart';

class CategoriesWidget extends StatelessWidget {
  final String categories;

  const CategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Text(
        categories.toUpperCase(),
        style: TextStyle(
            color: AppColors.primaryWhite.withValues(alpha: 0.4),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
      ),
    );
  }
}
