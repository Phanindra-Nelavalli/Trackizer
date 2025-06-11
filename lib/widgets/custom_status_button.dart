import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';

class CustomStatusButton extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;
  final Color color;
  const CustomStatusButton({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.gray60.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AppColors.gray30, fontSize: 12),
                ),
                SizedBox(height: 6),
                Text(
                  value, // Placeholder value, you can replace with actual data
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 2, width: 45, color: color),
        ],
      ),
    );
  }
}
