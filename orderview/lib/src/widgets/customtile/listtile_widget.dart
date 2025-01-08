import 'package:flutter/material.dart';
import 'package:orderview/src/utils/colors/colors.dart';

class ListTileCustom extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const ListTileCustom({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selectedIndex == index
              ? Color(0xFF24202C).withOpacity(0.8)
              : null,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      child: ListTile(
        leading: Icon(
          icon,
          color: selectedIndex == index
              ? AppColors.primaryBlue
              : Colors.grey.shade500,
          size: 22,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            title,
            style: TextStyle(
                color: selectedIndex == index
                    ? AppColors.primaryWhite
                    : Colors.grey.shade500,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () => onTap(index), // Chama a função onTap com o índice
      ),
    );
  }
}
